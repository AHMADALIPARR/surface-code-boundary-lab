# Validation checklist

- [ ] Record compiler and SDK versions for Quipper, Q#, and CUDA-Q.
- [ ] Compile each backend independently.
- [ ] Verify the ideal injected-error syndrome is `11` for the two parity checks.
- [ ] Confirm backend measurement bit ordering before comparing output strings.
- [ ] Validate the Stim fixture with the installed Stim parser.
- [ ] Confirm detector count and DEM extraction succeed.
- [ ] Confirm PyMatching graph metadata is inspected, not assumed.
- [ ] Run multiple shot counts and report confidence intervals for logical failure estimates.
- [ ] Test graph visualization on a circuit with real detector coordinates.
- [ ] Clearly label all synthetic results as simulation.
- [ ] Do not claim Willow/QPU execution without a trace or job record from an authorized hardware execution.
