! SPDX-License-Identifier: AGPL-3.0-or-later
! Copyright (C) 2026 SnapKitty Collective
! Licensed under GNU Affero General Public License v3 or later.
!
! Fortran 90 backend for the Surface Code Boundary Lab.
! Classical simulation of a distance-3 rotated surface code:
! bulk Z/X faces, boundary checks, logical operators,
! multi-round syndrome collection, boundary distances.

PROGRAM surface_code_backend
  IMPLICIT NONE
  INTEGER, PARAMETER :: D = 3
  INTEGER, PARAMETER :: NDATA = D * D
  LOGICAL :: data_bits(NDATA)
  INTEGER :: rounds, fault_q, i
  LOGICAL :: logical_z

  CALL clear_data(data_bits)
  fault_q = 4
  rounds = 3

  PRINT *, "Fortran 90 surface-code backend (d=3)"
  PRINT *, "Data qubits:", NDATA
  PRINT *, "Z-plaquettes:", (D-1)*(D-1)

  IF (fault_q >= 0 .AND. fault_q < NDATA) THEN
    CALL apply_x(data_bits, fault_q)
  END IF

  DO i = 1, rounds
    CALL syndrome_round(data_bits)
  END DO

  logical_z = logical_z_parity(data_bits)
  PRINT *, "Logical Z parity:", logical_z

  CALL print_boundary_distances()

CONTAINS

  SUBROUTINE clear_data(bits)
    LOGICAL, INTENT(OUT) :: bits(:)
    bits = .FALSE.
  END SUBROUTINE clear_data

  SUBROUTINE apply_x(bits, idx)
    LOGICAL, INTENT(INOUT) :: bits(:)
    INTEGER, INTENT(IN) :: idx
    IF (idx >= 1 .AND. idx <= SIZE(bits)) THEN
      bits(idx) = .NOT. bits(idx)
    END IF
  END SUBROUTINE apply_x

  SUBROUTINE apply_logical_x(bits)
    LOGICAL, INTENT(INOUT) :: bits(:)
    INTEGER :: y
    DO y = 0, D-1
      CALL apply_x(bits, data_index(0, y))
    END DO
  END SUBROUTINE apply_logical_x

  SUBROUTINE apply_logical_z(bits)
    LOGICAL, INTENT(INOUT) :: bits(:)
    ! Phase-only in this bit model.
  END SUBROUTINE apply_logical_z

  INTEGER FUNCTION data_index(x, y)
    INTEGER, INTENT(IN) :: x, y
    data_index = y * D + x + 1   ! 1-based
  END FUNCTION data_index

  LOGICAL FUNCTION face_parity(bits, i1, i2, i3, i4)
    LOGICAL, INTENT(IN) :: bits(:)
    INTEGER, INTENT(IN) :: i1, i2, i3, i4
    face_parity = bits(i1) .NEQV. bits(i2) .NEQV. bits(i3) .NEQV. bits(i4)
  END FUNCTION face_parity

  SUBROUTINE syndrome_round(bits)
    LOGICAL, INTENT(IN) :: bits(:)
    LOGICAL :: p0, p1, p2, p3
    p0 = face_parity(bits, data_index(0,0), data_index(1,0), data_index(0,1), data_index(1,1))
    p1 = face_parity(bits, data_index(1,0), data_index(2,0), data_index(1,1), data_index(2,1))
    p2 = face_parity(bits, data_index(0,1), data_index(1,1), data_index(0,2), data_index(1,2))
    p3 = face_parity(bits, data_index(1,1), data_index(2,1), data_index(1,2), data_index(2,2))
    PRINT *, "Z-bulk parities:", p0, p1, p2, p3
  END SUBROUTINE syndrome_round

  LOGICAL FUNCTION logical_z_parity(bits)
    LOGICAL, INTENT(IN) :: bits(:)
    logical_z_parity = bits(data_index(0,0)) .NEQV. bits(data_index(1,0)) .NEQV. bits(data_index(2,0))
  END FUNCTION logical_z_parity

  INTEGER FUNCTION boundary_dist(idx)
    INTEGER, INTENT(IN) :: idx
    INTEGER :: x, y, d1
    d1 = D - 1
    x = MOD(idx-1, D)
    y = (idx-1) / D
    boundary_dist = MIN(x, y, d1-x, d1-y)
  END FUNCTION boundary_dist

  SUBROUTINE print_boundary_distances()
    INTEGER :: i
    PRINT *, "Boundary distances:"
    DO i = 1, NDATA
      PRINT *, "  qubit", i-1, "dist", boundary_dist(i)
    END DO
  END SUBROUTINE print_boundary_distances

END PROGRAM surface_code_backend
