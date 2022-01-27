# Project
## Overview
This repo contains the data and code used for the study presented in the following paper:

[*Testing the locally-adaptive model of archaeological potential with hunter-gatherer sites in the Tanana River Valley, Alaska*]()

## Abstract

We report an assessment of the ability of the Locally Adaptive Model of Archaeological Potential (LAMAP) to estimate archaeological potential in relation to hunter-gatherer sites. The sample comprised 182 known sites in the Tanana Valley, Alaska, which was occupied solely by hunter-gatherers for about 14,500 years. To estimate archaeological potential, we employed physiographic variables such as elevation and slope, rather than variables that are known to vary on short time scales, like vegetation cover. Two tests of LAMAP were carried out. In the first, we used the location of a random selection of sites from all time periods to create a LAMAP model. We then evaluated the model with the remaining 92 sites. In the second test, we built a LAMAP model from 12 sites that pre-date 10,000 cal BP. This model was then tested with sites that post-date 10,000 cal BP. In both analyses, areas predicted to have higher archaeological potential contained higher frequencies of validation sites. Importantly, the performance of LAMAP in the two tests was comparable to its performance in previous tests using farming sites. The study extends the use of LAMAP to estimating archaeological potential of landscapes in relation to hunter-gatherer sites.

## Software
The R scripts contained in this repository are intended for replication efforts and to improve the transparency of research. They are, of course, provided without warranty or technical support. That said, questions about the code can be directed to me, Chris Carleton, at ccarleton@protonmail.com.

### R
This analysis described in the associated manuscript was performed in R. Thus, you may need to download the latest version of [R](https://www.r-project.org/) in order to make use of the scripts described below.

### LAMAP
The analysis centers on the use of an algorithm for which a pre-release R package is available and will be required for replication. See https://github.com/wccarleton/lamap.

### Nimble
This project made use of a Bayesian Analysis package called [Nimble](https://r-nimble.org/). See the Nimble website for documentation and a tutorial. Then, refer to the R scripts in this repo.

## Contact

[ORCID](https://orcid.org/0000-0001-7463-8638) |
[Google Scholar](https://scholar.google.com/citations?hl=en&user=0ZG-6CsAAAAJ) |
[Website](https://wccarleton.me)

## License

Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
