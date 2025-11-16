# Final-project_BIO350

- 10/30 
- beggining final project 
- be able to describe whats the input and output

- Goals for week of 11/3/25
    - Find a paper that conducts an experiment/analysis that you find interesting and is relatively related to class.
        I originally had a differnet paper that I was going to find code for to replicate it. that was too difficult so instead I found another paper on  divers causing avoidnace with collecting data for fish species distribution models. link: https://doi.org/10.7717/peerj.9246.

    - Read and document their raw data, code, analysis, and write up a brief introduction on the analysis and what their data/code/analysis looks like.
        Stamoulis et al. (2020) investigated whether including fish wariness, measured as minimum approach distance (MAD), improves species distribution models (SDMs) of reef fish biomass. They collected stereo-video transect data, recording fish counts, lengths, and MAD, and compiled environmental predictors such as depth, slope, bathymetric position, wave power, and turf algae cover at a grid-cell scale. Boosted regression tree (BRT) models were run with and without MAD, and generalized linear mixed models (GLMMs) tested MAD differences between marine protected and fished sites. The study found that incorporating MAD increased SDM accuracy, demonstrating the importance of accounting for behavioral biases when modeling reef fish distributions.
    - If you were to create a model (in other words, create an algorithm or machine learning method) what would your input data look like, and what are you trying to model or what does your output data look like?
        I will do a Poisson regression model to look at abundance including spatial predictors.
        Objective: Predict fish counts per transect/grid cell based on environmental variables and MPA/fished status. model potential hotspots of abundance based on location if im able to.
        Input: Depth, slope, wave power, BPI, turf algae (environmental), MPA/fished (management), latitude/longitude (spatial)
        Output: Predicted counts per site and estimates of predictor effects + spatial patterns

- 11/11
- did some simple plotting to visalize the data: plotting_data
- have input of abudance,environmental variables, and management status to work with
- will pick a scikit learn package next time and clean the data

- 11/13
    - Have data set selected: species_distribution_data.csv
    - Question: how do environmental variables and MPA/fished status influence fish abundance?
    - Model: Poisson regression to model fish abundance. In scikit, it's under GLMs and the process is in Poisson regression and non-normal loss.
    - set up model framework today
        - determine: x(transect, management, environmental: CCA_cover, coral_cover, macroalgae_cover, turf_cover, bathymetry) -> description (abundance of fish by transect based on factors)
    - train-test data split
    - run model example (MLP regressor/classifier): will do this monday so ready to do the Poisson on in class.
        - see y predicted vs. y actual
