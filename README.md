# Refdata

## Overview

This repository provides a collection of databases for benchmarking
quantum mechanical methods. The bulk of the repository are the `20_xx`
directories, which contain the structures for several popular
benchmark sets for which highly accurate reference data (or maybe
otherwise) are known. The structures are provided in xyz, Gaussian
input format (gjf), and, occasionally, in nwchem input format (nw). We
will go adding more formats as needed.

The `25_xx` directories contain crystal structures. In this case,
there are several subdirectories, corresponding to different
geometries. The `expt` directory is the experimental structure
(usually in cif format), and the `b86bpbe-xdm` directory contains the
B86bPBE-XDM equilibrium geometry, given as a Quantum ESPRESSO output
(scf.out, you can use
[critic2](https://github.com/aoterodelaroza/critic2) to convert
between the two).

The complete list of `20_xx` and `25_xx` databases is given below. The
list grows as we calculate new benchmark sets from the literature, but
contributions are very much welcome. 

The reference energies for these sets are in the `10_din` directory,
in din format. Din files contain a header at the top of the file with
the literature source for the reference data. Din files are plain-text
files that contain reference energies in kcal/mol for various
properties (reaction energies, binding energies, etc.). After the
header (a sequence of comments that start with `#`) the din file has a
sequence of blocks such as:

  ```
  -1
  A
  1
  B
  2
  C
  0
  6.493
  ```

This din-file block says that the energy for the reaction:
  
  ```
  A -> B + 2C
  ```

is 6.493 kcal/mol. (kcal/mol is the default unit in all inputs and
outputs of this repository.) Given this din file, the associated
scripts (in `40_*`, see below) will try to find output files of
calculations corresponding to the entries in the block. For instance,
in a Gaussian calculation, the script will fetch the energies from
A.log, B.log, and C.log, then calculate the reaction energy using the
din-file coefficients, and compare to the reference energy.

The `05_conversion` directory contains various bits and pieces. For
instance, scripts that I used to convert the literature reference data
from the format in the original papers to din files.

The `40_xx` directories contain octave scripts to manipulate the din
file and the structures, and to perform and evaluate the benchmark
calculations. Almost all scripts in this repository are written in
octave, with the occasional bash or awk script. The main script in
`50_eval` is `eval_driver.m`, which accepts a din file, a target
directory, and an interpretation recipe (e.g. read Quantum ESPRESSO
outputs). `eval_driver.m` will read and parse the din file, find all
the necessary energies from the output files in the target directory,
calculate the corresponding reaction energies, compare to the
reference energies, and print out a table and some useful statistics.

The `50_fit` directory contains routines for running XDM
parametrizations. The main script is `fit_driver.m`, which works
pretty much the same as `eval_driver.m`, except in this case the
intent is to find the XDM damping function coefficients for a given
set (usually, `20_kb49` but occasionally `20_kb65`). The `xdm.param`
file in the root of this repository contains the master list of XDM
parameters, and is exactly the same as the equivalent file in the
[postg](https://github.com/aoterodelaroza/postg) repository.

## Manifest (molecules)

| Set        | Directory          | Contents                                                       | Level                               | Refs                                                        |
|------------|--------------------|----------------------------------------------------------------|-------------------------------------|-------------------------------------------------------------|
| 3B69       | 20_3b69/           | Three-body energies of molecular trimers                       | CCSD(T)/CBS                         | [rezac2015]                                                 |
| A24        | 20_a24/            | Dimer binding energies (small molecules, non-equilibrium)      | CCSD(T)/CBS                         | [rezac2013]                                                 |
| ACHC       | 20_achc/           | Dimer binding energies (adenine-cytosine steps)                | DW-CCSD(T**)-F12/aDZ                | [parker2015],[smith2016]                                    |
| BAUZA      | 20_bauza/          | Dimer binding energies (halogen-bonded systems)                | CCSD(T)/CBS                         | [bauza2013],[aor2014b]                                      |
| BBI        | 20_bbi/            | Dimer binding energies (backbone-backbone interactions)        | CCSD(T)-F12/CBS                     | [smith2016],[burns2017]                                     |
| BDE03      | 20_bde03/          | Bond dissociation energies (back-corrected electronic De)      | Back-corrected experimental         | [johnson2003]                                               |
| BH         | 20_bh/             | Barrier heights                                                | Best estimates (QCISD/MG3 geometries) | [lynch2001]                                                 |
| BH9        | 20_bh9/            | Barrier heights and reaction energies (organic/biological)     | CCSD(T)/CBS                         | [prasad2022]                                                |
| CHAL336    | 20_chal336/        | Dimer binding energies (chalcogen bonds)                       | DLPNO-CCSD(T)/CBS, some W1-F12      | [mehta2021]                                                 |
| CT         | 20_ct/             | Dimer binding energies (charge transfer complexes)             | W1/W2                               | [zhao2005]                                                  |
| CYCLO70    | 20_cyclo70/        | Pericyclic barrier heights and reaction energies               | DLPNO-CCSD(T)                       | [alfonsoramos2025]                                          |
| D1200      | 20_d1200/          | Dimer binding energies (dispersion, extended chemical space)   | CCSD(T)/CBS                         | [rezac2022]                                                 |
| D442x10    | 20_d442x10/        | D1200 subset with varying intermolecular distances             | CCSD(T)/CBS                         | [rezac2022]                                                 |
| EXL8       | 20_exl8/           | Binding energies (extra-large dimers)                          | CIM-DLPNO-CCSD(T)||RI-MP2           | [ni2021]                                                    |
| G3         | 20_g3/             | Atomization energies                                           | G3                                  | [curtiss2000]                                               |
| HB300SPX   | 20_hb300spx/       | Dissociation curves (H bonds involving S, P, and halogens)     | CCSD(T)/CBS                         | [rezac2020a]                                                |
| HB375x10   | 20_hb375x10/       | Dissociation curves (OH, NH, and CH hydrogen bonds)            | CCSD(T)/CBS                         | [rezac2020]                                                 |
| HBC6       | 20_hbc6/           | Dissociation curves double-hydrogen-bonded dimers              | CCSD(T)/CBS                         | [thanthiriwatte2011],[marshall2011]                         |
| HSG        | 20_hsg/            | Dimer binding energies (protein reaction site)                 | CCSD(T)/CBS                         | [faver2011]                                                 |
| ICE13      | 20_ice13/          | Lattice energies of ice polymorphs (absolute and relative)     | Diffusion Monte Carlo               | [dellapia2022]                                              |
| IHB100x10  | 20_ihb100x10/      | Dissociation curves (charged hydrogen-bonded dimers)           | CCSD(T)/CBS                         | [rezac2020]                                                 |
| IHD302     | 20_ihd302/         | Inorganic heterocycle dimerization energies                    | DLPNO-CCSD(T)/CBS                   | [gasevic2024]                                               |
| IONICHB    | 20_ionichb/        | Dimer binding energies (charged systems)                       | CCSD(T)/CBS                         | [rezac2012b]                                                |
| ISOM       | 20_isom/           | Isomerization reaction energies                                | Back-corrected experimental/CCSD(T) | [grimme2007]                                                |
| KB49       | 20_kb49/           | Dimer binding energies (small molecules)                       | Various (see ref. & web)            | [kannemann2010],[erin-web]                                  |
| KB65       | 20_kb65/           | Dimer binding energies (small molecules)                       | Various (see ref. & web)            | [kannemann2010],[erin-web]                                  |
| L7         | 20_l7/             | Dimer binding energies (large-ish molecules)                   | QCISD(T)/CBS                        | [sedlak2013]                                                |
| LM26       | 20_lm26/           | Exfoliation energies of layered materials (no din, see README) | RPA                                 | [bjorkman2012]                                              |
| MBCC-VIE   | 20_mbcc_vie/       | Vertical ionization energies                                   | Experimental/CCSD(T) delta-SCF      | [mckechnie2015]                                             |
| NBC10EXT   | 20_nbc10ext/       | Dissociation curves (dispersion-bound molecules)               | CCSD(T)/CBS                         | [burns2011],[smith2016],[marshall2011]                      |
| P26        | 20_p26/            | Conformational energies of small peptides (two wrong, see din) | CCSD(T)/CBS                         | [valdes2008]                                                |
| POLYPYR21  | 20_polypyr21/      | Relative energies of expanded porphyrins                       | CCSD(T)/cc-pVDZ (no p on H)         | [sylvetsky2020]                                             |
| R739x5     | 20_r739x5/         | Dissociation curves (repulsive contacts)                       | CCSD(T)/CBS                         | [kriz2021]                                                  |
| S12L       | 20_s12l/           | Dimer binding energies (large host-guest complexes)            | Back-corrected experimental/QMC     | [grimme2012],[risthaus2013],[ambrosetti2015]                |
| S22        | 20_s22/            | Dimer binding energies (small molecules)                       | CCSD(T)/CBS                         | [jurecka2006],[podeszwa2010],[marchetti2011],[marshall2011] |
| S22x5      | 20_s22x5/          | S22 with varying intermolecular distances                      | CCSD(T)/CBS                         | [jurecka2006],[grafova2010]                                 |
| S22x7      | 20_s22x7/          | S22 with varying intermolecular distances                      | DW-CCSD(T**)-F12/CBS                | [jurecka2006],[grafova2010],[smith2016]                     |
| S30L       | 20_s30l/           | Dimer binding energies (large host-guest complexes)            | Back-corrected experimental         | [sure2015]                                                  |
| S66        | 20_s66/            | Dimer binding energies (small molecules)                       | CCSD(T)/CBS                         | [rezac2011],[dilabio2013]                                   |
| S66x8      | 20_s66x8/          | S66 with varying intermolecular distances                      | CCSD(F12*)(T)/CBS                   | [rezac2011],[brauer2016]                                    |
| S66x10     | 20_s66x10/         | S66 with varying intermolecular distances                      | DW-CCSD(T**)-F12/CBS                | [rezac2011]                                                 |
| SH250x10   | 20_sh250x10/       | Dissociation curves (sigma-hole interactions)                  | CCSD(T)/CBS                         | [kriz2022]                                                  |
| SSI        | 20_ssi/            | Dimer binding energies (sidechain-sidechain interactions)      | CCSD(T)-F12/CBS                     | [smith2016],[burns2017]                                     |
| SULFURx8   | 20_sulfur_x8/      | Dimer binding energies (molecules with divalent S)             | CCSD(T)/CBS                         | [mintz2012]                                                 |
| TM         | 20_tm/             | Ligand-removal energies of transiton metal complexes           | Back-corrected experimental         | [johnson2009]                                               |
| W1-SN2-BH  | 20_w1_sn2_bh/      | Barrier heights for SN2 reactions with anionic nucleophiles    | W1w                                 | [karton2026]                                                |
| W4-17      | 20_w4-17/          | Atomization energies (small molecules and radicals)            | W4                                  | [karton2017]                                                |
| WATER      | 20_water/          | Binding energies (water clusters)                              | CCSD(T)/CBS                         | [temelso2011]                                               |
| WATER25x10 | 20_water2510/      | Dimer binding energies (water dimer PES)                       | CCSD(T)/CBS                         | [mas2000],[bukowski2007],[bukowski2008],[smith2016]         |
| X40        | 20_x40/            | Dimer binding energies (halogen-containing molecules)          | CCSD(T)/CBS                         | [rezac2012a]                                                |
| X40x10     | 20_x40x10/         | X40 with varying intermolecular distances                      | CCSD(T)/CBS                         | [rezac2012a]                                                |
| XB18       | 20_xb18/           | Dimer binding energies (halogen-bonded systems)                | CCSD(T)/CBS                         | [kozuch2013]                                                |
| XB51       | 20_xb51/           | Dimer binding energies (halogen-bonded systems)                | CCSD(T)/CBS                         | [kozuch2013]                                                |

[curtiss2000]: https://dx.doi.org/10.1063/1.481336
[mas2000]: https://dx.doi.org/10.1063/1.1311289
[lynch2001]: https://dx.doi.org/10.1021/jp004262z
[johnson2003]: https://dx.doi.org/10.1021/jp035315q
[zhao2005]: https://dx.doi.org/10.1021/ct049851d
[jurecka2006]: http://dx.doi.org/10.1039/B600027D
[bukowski2007]: http://dx.doi.org/10.1126/science.1136371
[grimme2007]: http://dx.doi.org/10.1021/jo062446p
[bukowski2008]: https://dx.doi.org/10.1063/1.2832746
[valdes2008]: https://dx.doi.org/10.1039/b719294k
[johnson2009]: https://dx.doi.org/10.1139/V09-102
[grafova2010]: https://dx.doi.org/10.1021/ct1002253
[kannemann2010]: https://dx.doi.org/10.1021/ct900699r
[podeszwa2010]: http://dx.doi.org/10.1039/B926808A
[burns2011]: https://dx.doi.org/10.1063/1.3545971
[faver2011]: https://dx.doi.org/10.1021/ct100563b
[marchetti2011]: http://dx.doi.org/10.1039/B804334E
[marshall2011]: https://dx.doi.org/10.1063/1.3659142
[temelso2011]: https://dx.doi.org/10.1021/jp2069489
[thanthiriwatte2011]: https://dx.doi.org/10.1021/ct100469b
[rezac2011]: https://dx.doi.org/10.1021/ct2002946
[grimme2012]: https://dx.doi.org/10.1002/chem.201200497
[mintz2012]: https://dx.doi.org/10.1021/jp209536e
[rezac2012a]: https://dx.doi.org/10.1021/ct300647k
[rezac2012b]: https://dx.doi.org/10.1021/ct200751e
[bauza2013]: https://dx.doi.org/10.1021/ct400818v
[dilabio2013]: https://dx.doi.org/10.1039/C3CP51559A
[kozuch2013]: https://dx.doi.org/10.1021/ct301064t
[rezac2013]: https://dx.doi.org/10.1021/ct400057w
[risthaus2013]: https://dx.doi.org/10.1021/ct301081n
[sedlak2013]: https://dx.doi.org/10.1021/ct400036b
[aor2014b]: https://dx.doi.org/10.1021/ct500899h
[ambrosetti2015]: https://dx.doi.org/10.1021/jz402663k
[mckechnie2015]: https://dx.doi.org/10.1063/1.4921037
[parker2015]: https://dx.doi.org/10.1021/acs.jctc.5b00588
[sure2015]: https://dx.doi.org/10.1021/acs.jctc.5b00296
[brauer2016]: http://dx.doi.org/10.1039/c6cp00688d
[smith2016]: http://dx.doi.org/10.1021/acs.jpclett.6b00780
[burns2017]: https://dx.doi.org/10.1063/1.5001028
[goerigk2017]: https://dx.doi.org/10.1039/C7CP04913G
[rezac2020]: https://doi.org/10.1021/acs.jctc.9b01265
[rezac2020a]: https://doi.org/10.1021/acs.jctc.0c00715
[kriz2021]: https://doi.org/10.1021/acs.jctc.0c01341
[kriz2022]: https://doi.org/10.1039/D2CP01600A
[rezac2022]: https://doi.org/10.1039/D2CP01602H
[rezac2015]: https://dx.doi.org/10.1021/acs.jctc.5b00281
[karton2017]: https://dx.doi.org/10.1002/jcc.24854
[dolgonos2019]: https://dx.doi.org/10.1039/C9CP04488D
[sylvetsky2020]: https://dx.doi.org/10.1021/acs.jctc.0c00297
[mehta2021]: https://dx.doi.org/10.1021/acs.jctc.1c00006
[ni2021]: https://dx.doi.org/10.1021/acs.jctc.0c00831
[prasad2022]: https://dx.doi.org/10.1021/acs.jctc.1c00694
[dellapia2022]: https://dx.doi.org/10.1063/5.0102645
[gasevic2024]: https://dx.doi.org/10.1039/D3CP06217A
[alfonsoramos2025]: https://dx.doi.org/10.1021/acs.jctc.5c00925
[karton2026]: https://dx.doi.org/10.1021/acs.jpca.6c00424
[bjorkman2012]: https://dx.doi.org/10.1103/PhysRevLett.108.235502
[liang2025]: https://arxiv.org/abs/2508.13468
[erin-web]: https://erin-r-johnson.github.io/

## Collections (GMTKN55 and GSCDB138)

Two large third-party collections are kept separately from the `20_xx`
sets, because each ships its own geometries and its own set of din files:

| Collection | Din files             | Structures                   | Subsets | Reactions | Ref              |
|------------|-----------------------|------------------------------|---------|-----------|------------------|
| GMTKN55    | `10_din-GMTKN55/`     | `30_collection-GMTKN55/`     | 57      | 1689      | [goerigk2017]    |
| GSCDB138   | `10_din-GSCDB138/`    | `30_collection-GSCDB138/`    | 138     | 8383      | [liang2025]      |

One din file per subset, and one structure subdirectory per subset with the
same name (the exception is `bh76rc.din`, which reuses the `bh76/`
geometries). A few notes worth knowing before you use them:

- The GMTKN55 collection holds 55 official subsets **minus S22 and S66**
  (those are top-level sets here, `20_s22/` and `20_s66/`) **plus** four
  GMTKN30-legacy subsets: `cyconf`, `mb08-165`, `o3add6` and `w4-08`.
- `bh76.din` has **68** reactions, not 76: the official list contains eight
  exact duplicates, which are removed here. Error statistics from this file
  are therefore over 68 points and are not directly comparable to published
  BH76 numbers.
- `water27.din` carries the current official values, which differ from the
  `grimme-lab/GMTKN55` GitHub mirror in 26 of 27 entries. The values here
  are the correct ones.
- GSCDB138 is pinned to the arXiv-v1 release of the Gold-Standard Chemical
  Database. Upstream has since renamed it GSCDB137, revised 52 of the 66
  S66 values and dropped six reactions.
- Several sets appear both here and in `10_din/` with **different**
  reference data (A24, S22, S66, X40, and ISO34 as `isom.din`); HSG is the
  only one that is identical in both places. Pick one deliberately.

## Manifest (crystals)

| Set       | Directory     | Contents                                                            | Level                       | Refs                   |
|-----------|---------------|---------------------------------------------------------------------|-----------------------------|------------------------|
| EE        | 25_ee/        | Enantiomeric excess at the chiral eutectic in solution                 | B86bPBE-XDM or experimental | [aor2014],[aor2016]   |
| POLYMORPH | 25_polymorph/ | First three candidates from all groups for first 5 CCDC blind tests | B86bPBE-XDM                 | [aor2017a],[aor2017b]  |
| PV18      | 25_pv18/      | Relative energies of 19 polymorph pairs (per molecule)              | B86bPBE-XDM                 | --                     |
| X23       | 25_x23/       | Lattice energies of small molecular crystals                        | Back-corrected experimental | [aor2012],[reilly2013],[dolgonos2019] |

[aor2012]: https://dx.doi.org/10.1063/1.4738961
[reilly2013]: https://dx.doi.org/10.1063/1.4812819
[aor2014]: https://dx.doi.org/10.1002/anie.201403541
[aor2016]: https://dx.doi.org/10.1021/acs.cgd.6b01088
[aor2017a]: https://dx.doi.org/10.1021/acs.jctc.6b00679
[aor2017b]: https://dx.doi.org/10.1021/acs.jctc.7b00715

