# Surface Code Boundary Lab — Atlas

About 2000 words. English, then Traditional Chinese.

## English

This repository is a laboratory for finite surface codes, boundary-distance analysis, multi-language circuit backends, and a set of experimental cipher and maze modules. It is licensed AGPL-3.0-or-later under the SnapKitty Collective and the Bel esprit D'accord Trust. The live site is at https://ahmadaliparr.github.io/surface-code-boundary-lab/.

A surface code protects a logical qubit by topology. On a finite patch the topology has edges. The vulnerability index used here is the shortest path, on the decoder matching graph, from a detector to the nearest boundary node. Short distances mean a matching can terminate at the boundary cheaply; those detectors are more exposed. The map in visuals/vulnerability_map.jpg colors that index. Warm tones mark short distances, cool tones mark longer ones. Corner and edge detectors score low; the center scores high. The same procedure works for biased noise because the distances come from the actual matching graph, not a geometric shortcut.

The analysis path starts in scripts/generate_surface_code.py, which builds a Stim circuit for a rotated surface-code memory. scripts/analyze_boundary_vulnerability.py loads that circuit, extracts a detector error model, builds a PyMatching graph, marks boundary nodes, and computes shortest-path distances. scripts/mwpm_telemetry_server.py streams defect coordinates over a WebSocket. The React Three Fiber view in frontend/src/QuantumLattice.jsx draws the lattice and colors active defects from that stream. docs/ANALYSIS_CONTRACT.md states the input and output contract. docs/VALIDATION.md lists the checks that must pass before a result is treated as reproducible.

Circuit backends live under src/. CUDA-Q kernels in src/cudaq implement Z and X bulk and boundary stabilizers and multi-round memory. Q# operations in src/qsharp do the same in the Quantum Development Kit style. Quipper descriptions in src/quipper express the fragment in Haskell. Classical simulators exist in Rust, C++, C, Fortran 90, and Forth. None of these is claimed to emit a circuit automatically equivalent to the Stim factory. They exist so the same parity-check idea can be written in the languages different groups already use, and so later equivalence checking has concrete artifacts.

src/mlir holds a textual MLIR dialect sketch and a Python interpreter. The interpreter can pull bytes from the ANU quantum random number generator, which measures vacuum fluctuations, and inject them as depolarizing noise. Independent batches are XORed together before use. If the legacy endpoint is rate-limited, the runner falls back to the system RNG.

src/sim is a small statevector simulator. It supports H, X, Z, and CNOT, plus custom oracles. src/sim/cipher_packages.py exposes the cipher modules as oracles so a circuit can phase-mark or bit-flip from a classical encryption of a register. The Bell circuit is H on qubit 0 followed by CNOT from 0 to 1. Its probabilities are one half on |00⟩ and one half on |11⟩.

The cipher modules are in src/cipher. Z408 implements homophonic substitution with reverse, mirror, and section paths. Z340 adds periodic row flips and diagonal reading on a 17-column grid. aes_mixcolumns.py implements AES MixColumns and its inverse over GF(2^8), checked against the FIPS 197 test vector. maze_block_cipher.py builds a block cipher whose key schedule mixes path hashes from the maze with round constants derived from quantum speed-limit bounds. The round function is AddRoundKey, a mirror substitution, then MixColumns. The inverse uses InvMixColumns and round-trips.

src/maze contains the Voyager maze, the Many-Worlds extension, the QSL kernel, and the bifurcation engine. Nodes are Spine 64 hex-cipher tokens. A mock key gates entry. MirrorFlip is an involution. Many-Worlds forks each branch into two phase-shifted children and prunes to a capacity. QSL checks heap isolation with a p-adic ultrametric and checks evolution time against Mandelstam-Tamm and Margolus-Levitin bounds. The bifurcation engine drives a logistic map whose parameter depends on a multiplicity-weighted sum of shadow-prime ordinates, injects deterministic phase noise, and prunes branches that fail the speed limit or leak out of the unit interval.

docs/multiplicity holds two formal notes. The 64-layer Premidoral spine lists lemmas 1 through 32 on categorical, topological, quantum, and QMHES foundations, then lemmas 33 through 64 on the layered spine: indexing, embeddings, a holographic boundary at layer 63, Fock cutoffs, even-layer entropy injection, and an integrity invariant. The Spine 64 hex cipher note records the token format. The integer field is the prime in hexadecimal. The fractional field is a tag. Multiplicity is stored beside the token, not inside it.

Interactive pages are served from the repository root because GitHub Pages is configured to publish that root. circuit.html draws gates and wires algorithmically, steps a statevector, and updates a Bloch sphere for qubit 0. quantum_lens.html is a control-room view with a 64-qubit array, a coupling grid, and a branching swarm. maze.html is the clickable node maze. z408.html and cipher.html are the cipher benches. docs/library.html is the art-library index. A .nojekyll file disables Jekyll so the raw HTML is served. Visuals include the vulnerability map, a lattice animation, a pipeline diagram, and SVG diagrams of a Bloch sphere, a Bell circuit, a surface-code lattice, and a small gate fragment.

The Makefile targets install Python dependencies, run the Stim path, and build the C, C++, Fortran, and Rust backends. Continuous integration on push and pull request runs the Python path and the native builds. The license is GNU Affero General Public License version 3 or later. Source files carry SPDX headers.


The laboratory is organized so that a reader can move from a physical idea to a number without losing the geometry. The physical idea is simple. A detector that can reach a boundary with a short chain of errors is easier for a minimum-weight perfect matching decoder to explain. The number is the length of that shortest chain. The geometry is the matching graph built from the detector error model, not a picture of the lattice drawn by hand. That is why the same code path remains valid when the noise is biased or the lattice is irregular. The map is only a rendering of those distances.

Stim is used because it can generate a circuit, sample it, and produce a detector error model in one stack. The factory in scripts/generate_surface_code.py is deliberately small. A small circuit lets a person inspect detector coordinates and boundary semantics by eye. The analysis script then does the mechanical work: load, extract, graph, mark boundaries, compute distances, and write a table. The telemetry server exists so the frontend does not have to recompute the matching. It only paints what the server sends.

Each classical backend follows the same shape. There is a data register of nine bits for distance three. There is a syndrome routine that computes the four face parities. There is a logical-Z parity over the first row. There is a memory routine that repeats the syndrome for a chosen number of rounds and optionally applies a fault. The languages differ. The operations do not. Rust adds tests. Fortran and C are compiled with gfortran and gcc. Forth is a word set that can be loaded in gforth. These are not production decoders. They are reference implementations of the same fragment.

The MLIR sketch is textual. It names operations: allocate data, apply X, inject entropy, take a syndrome round, read logical Z. The Python interpreter is the thing that runs. Entropy injection is the interesting part. The ANU service returns unsigned bytes from a quantum optics experiment. The runner requests a batch, optionally XORs several batches, and uses the bytes as uniform draws. A draw below a chosen probability flips a data bit. That is a classical stand-in for depolarizing noise, fed by a quantum source. The rate limit on the old endpoint is about one request per minute, so the runner caches.

The statevector simulator is pedagogical. Two qubits, Hadamard, controlled not, and the probabilities come out even on the correlated basis states. Cipher oracles are attached the same way any other gate is attached. The oracle looks at a classical encryption of a fixed string and may apply a Z on qubit zero if the ciphertext length is odd. It is a hook, not a claim that the cipher is quantum.

Z408 and Z340 are mechanical studies of historical cryptograms. They implement homophonic substitution and the reading-order tricks associated with those ciphers: full reversal, row mirror at width 17, section reversal, periodic row flip, and diagonal traversal. They do not reproduce solved plaintext. MixColumns is the standard AES linear layer. The column test from the federal standard is the correctness check. The maze block cipher is a demonstration that the maze path and the speed-limit constants can be stirred into a key schedule. It is not offered as a secure primitive.

The maze is a graph whose nodes are hex tokens from the Spine 64 table. The start token is 0x02.14AB. The goal token is 0x35.67AB. A presented key is hashed and compared with the hash of the mock key. A wrong key leaves the agent locked. A right key allows steps. Distance between nodes is a crude 2-adic valuation of the XOR of their integer fields. Many-Worlds replaces the single agent with a list of branches. Each step forks a branch into two children with opposite phases. Branches that reach the goal are kept. The list is trimmed to a maximum length by amplitude magnitude.

QSL in this repository means two checks. Separation: two addresses are isolated if their ultrametric distance exceeds a threshold. Speed: elapsed time must be at least the maximum of the Mandelstam-Tamm and Margolus-Levitin times, and at least a demo floor. The bifurcation engine uses those checks as a gate. Agents whose logistic state leaves the unit interval are pruned. Agents that survive may be cloned when the clock hits a multiple of five. The parameter mu is computed from a weighted sum of shadow ordinates. In the demo the raw mu sits above the logistic window, so the step scales it before the map.

The Premidoral notes are formalizations under the Bel esprit D'accord Trust. They are not a restatement of Hilbert-Samuel multiplicity and not a restatement of the classical multiplicity-one theorems. Lemmas 1 to 32 set a categorical and physical vocabulary. Lemmas 33 to 64 fix a 64-layer spine with a boundary at layer 63, even-layer entropy injection, and a signed integrity sum. The hex cipher matrix is illustrative. Its integer field recovers the prime. Its fractional field does not recover the ordinate to the printed precision, and it does not contain the multiplicity. A round trip that needs both must use the companion table.

Pages publishes the repository root. That is why circuit.html, quantum_lens.html, maze.html, z408.html, and cipher.html sit at the top level as well as under docs and gui. The art library at the root index lists the live pages and the diagrams. Jekyll was failing the build, so .nojekyll forces a raw file publish. After that change the circuit page, the lens, and the maze return successfully.

What this laboratory measures is a distance on a matching graph. What it provides is that distance, computed the same way, from several languages, plus a visualization, plus a set of experimental modules that share the Spine 64 tokens. The atlas is the map of those pieces.

## 繁體中文

本儲存庫是一個有限表面碼實驗室，包含邊界距離分析、多語言電路後端，以及一組實驗性的密碼與迷宮模組。授權為 AGPL-3.0 或更新版本，歸屬於 SnapKitty Collective 與 Bel esprit D'accord Trust。線上站點位於 https://ahmadaliparr.github.io/surface-code-boundary-lab/。

表面碼以拓撲保護邏輯量子位。有限晶格的拓撲有邊界。此處使用的脆弱度指標，是解碼器匹配圖上從一個偵測器到最近邊界節點的最短路徑。距離短表示匹配可以低成本在邊界終止，該偵測器較暴露。visuals/vulnerability_map.jpg 以顏色顯示此指標。暖色為短距離，冷色為長距離。角落與邊緣得分低，中心得分高。因為距離來自實際匹配圖而非幾何捷徑，同一程序也適用於偏置噪聲。

分析路徑從 scripts/generate_surface_code.py 開始，它為旋轉表面碼記憶體建立 Stim 電路。scripts/analyze_boundary_vulnerability.py 載入電路、提取偵測器錯誤模型、建立 PyMatching 圖、標記邊界節點並計算最短路徑。scripts/mwpm_telemetry_server.py 以 WebSocket 串流缺陷座標。frontend/src/QuantumLattice.jsx 的 React Three Fiber 視圖繪製晶格並依串流著色。docs/ANALYSIS_CONTRACT.md 規定輸入與輸出契約。docs/VALIDATION.md 列出結果可重現前必須通過的檢查。

電路後端位於 src/。src/cudaq 的 CUDA-Q 核心實作 Z 與 X 的體與邊界穩定子以及多輪記憶。src/qsharp 的 Q# 操作以 Quantum Development Kit 風格實作相同片段。src/quipper 以 Haskell 描述。古典模擬器有 Rust、C++、C、Fortran 90 與 Forth。這些後端並不被宣稱會自動產生與 Stim 工廠等價的電路。它們的目的是讓同一奇偶檢查概念能以各研究群既有的語言寫出，並為日後的等價檢查提供具體成品。

src/mlir 包含文字形式的 MLIR 方言草圖與 Python 解釋器。解釋器可從澳洲國立大學量子亂數產生器取得位元組。該服務測量真空漲落。獨立批次在使用前以互斥或混合。若舊端點被速率限制，則退回系統亂數。

src/sim 是小型態向量模擬器，支援 H、X、Z、CNOT 與自訂 oracle。src/sim/cipher_packages.py 將密碼模組暴露為 oracle，使電路能依暫存器的古典加密結果施加相位或位元翻轉。貝爾電路是在量子位 0 上做 H，再以 0 控制 1 的 CNOT。其機率為 |00⟩ 與 |11⟩ 各二分之一。

密碼模組在 src/cipher。Z408 實作同音替代，並含反向、鏡像與分段路徑。Z340 在 17 欄網格上加入週期列翻轉與對角讀取。aes_mixcolumns.py 在 GF(2^8) 上實作 AES MixColumns 及其逆運算，並以 FIPS 197 測試向量驗證。maze_block_cipher.py 的金鑰排程混合迷宮路徑雜湊與由量子速度極限導出的輪常數。輪函數為 AddRoundKey、鏡像替代、再 MixColumns。逆運算使用 InvMixColumns，可往返。

src/maze 包含 Voyager 迷宮、多世界擴充、QSL 核心與分岔引擎。節點是 Spine 64 十六進位密碼權杖。模擬金鑰控制進入。MirrorFlip 是對合。多世界將每個分支分成兩個相位偏移的子分支，並修剪至容量上限。QSL 以 p-進超度量檢查堆積隔離，並以 Mandelstam-Tamm 與 Margolus-Levitin 界限檢查演化時間。分岔引擎驅動邏輯映射，其參數依賴影子質數虛部的重數加權和，注入確定性相位噪聲，並修剪違反速度極限或逸出單位區間的分支。

docs/multiplicity 有兩份形式筆記。64 層 Premidoral 脊柱列出引理 1 至 32，涵蓋範疇、拓撲、量子與 QMHES 基礎，再列出引理 33 至 64，涵蓋分層脊柱：索引、嵌入、第 63 層全像邊界、Fock 截斷、偶數層熵注入與完整性不變量。Spine 64 十六進位密碼筆記記錄權杖格式。整數欄是質數的十六進位。小數欄是標籤。重數存放在權杖之外。

互動頁面從儲存庫根目錄提供，因為 GitHub Pages 設定為發布該根目錄。circuit.html 以演算法繪製閘與線，逐步推進態向量，並更新量子位 0 的布洛赫球。quantum_lens.html 是控制室視圖，含 64 量子位陣列、耦合網格與分支群。maze.html 是可點擊節點迷宮。z408.html 與 cipher.html 是密碼工作台。docs/library.html 是藝術圖書館索引。.nojekyll 停用 Jekyll，使原始 HTML 被直接提供。視覺素材包含脆弱度圖、晶格動畫、管線圖，以及布洛赫球、貝爾電路、表面碼晶格與小型閘片段的 SVG。

Makefile 可安裝 Python 相依、執行 Stim 路徑，並建置 C、C++、Fortran 與 Rust 後端。推送與拉取請求上的持續整合會執行 Python 路徑與原生建置。授權為 GNU Affero 通用公眾授權條款第三版或更新版本。原始檔帶有 SPDX 標頭。
