# Final-project_BIO350

- 10/30 
- beginning final project 
- be able to describe what the input and output are

**Introduction, analysis method, paper description**
- Goals for week of 11/3/25
    - Find a paper that conducts an experiment/analysis that you find interesting and is relatively related to class.
        I originally had a different paper that I was going to find code for to replicate it. That was too difficult, so instead, I found another paper on  divers causing avoidance with collecting data for fish species distribution models. link: https://doi.org/10.7717/peerj.9246.

    - Read and document their raw data, code, analysis, and write up a brief introduction on the analysis and what their data/code/analysis looks like.
        Stamoulis et al. (2020) investigated whether including fish wariness, measured as minimum approach distance (MAD), improves species distribution models (SDMs) of reef fish biomass. They collected stereo-video transect data, recording fish counts, lengths, and MAD, and compiled environmental predictors such as depth, slope, bathymetric position, wave power, and turf algae cover at a grid-cell scale. Boosted regression tree (BRT) models were run with and without MAD, and generalized linear mixed models (GLMMs) tested MAD differences between marine protected and fished sites. The study found that incorporating MAD increased SDM accuracy, demonstrating the importance of accounting for behavioral biases when modeling reef fish distributions.
    - If you were to create a model (in other words, create an algorithm or machine learning method), what would your input data look like, and what are you trying to model, or what does your output data look like?
        I will do a Poisson regression model to look at abundance, including spatial predictors.
        Objective: Predict fish counts per transect/grid cell based on environmental variables and MPA/fished status. Model potential hotspots of abundance based on location if I'm able to.
        Input: Depth, slope, wave power, BPI, turf algae (environmental), MPA/fished (management), latitude/longitude (spatial)
        Output: Predicted counts per site and estimates of predictor effects + spatial patterns
**Creating example data or finding raw data to use, data cleaning, data visualization, and choosing your machine learning method**
- 11/11
- did some simple plotting to visualize the data: plotting_data
- have input of abundance, environmental variables, and management status to work with
- will pick a scikit learn package next time and clean the data

- 11/13
    - Have data set selected: species_distribution_data.csv
    - Question: How do environmental variables and MPA/fished status influence fish abundance?
    - Model: Poisson regression to model fish abundance. In scikit, it's under GLMs, and the process is in Poisson regression and non-normal loss.
    - Set up the model framework today
        - determine: x(abundace, management, environmental: CCA_cover, coral_cover, macroalgae_cover, turf_cover, bathymetry) -> description (abundance of fish based on factors)
    - train-test data split
    - run model example (MLP regressor/classifier): will do this Monday so ready to do the Poisson on in class. This is the Final_project_data_training.ipynb
        - see y predicted vs. y actual
    - hypothesis: abundance will increase within MPAs and with more cover, as well as a lower bathymetry.

**Data analysis**
- 11/17
    - Ran a clean and train/test data split on species_distribution_data.csv, the same as the practice on the nitrate file we did 11/13. 
    - Not sure what to infer from the heatmap it made, but the data seems to work well, so I will do Poisson Regression next class.

- goals for week of 11/17
    - What was the original paper about?
        - The original paper was about the avoidance behavior of fish during surveys for species distribution models (SDMs)
    - Did it model anything, or are you just using their data?
        - I am just using their data
    - What is your question, or idea?
        - My question is how environmental and protection status affects fish abundance
    - What are you specifically trying to model?
        - I am trying to model how my predictor variables (bathymetry, management/protection status, CCA cover, macroalgae cover, coral cover, and turf cover) affect the expected abundance of fish at each site.
        - Why? How will it answer your question/idea?
            - This model allows me to determine which habitat and management variables are most important in predicting fish abundance and whether protected areas and environmental conditions are associated with higher or lower abundance.
    - What is your input data type or structure?
        - environmental data and protection status
    - What is your output data type?
        - continuous numerical abundance, representing the predicted number of fish at each site.
    - What type of model have you decided to use to model your data?
        - I'm using a Random Forest Regressor found in the Random_forest_model_FP.ipynb
        - I did the Poisson regression that I originally said I would do; however, it didn't fit the data very well. I think it's because the mean doesn't ~ the variance due to overdispersion. So Dr. Denni recommended I switch to a Random Tree Regressor. I looked at doing a negative binomial too, but that isn't available on Scikit learn. The Poisson regression is found in the train_test_PoissonRegression.ipynb file
    - Practical:
        - Have your data loaded
            - done
        - Plot initial data visualization
            - done
        - Explain your data type and input/output plans for your model
            - done
        - Create a train/test data split
            - done. ran the 80/20 split and the LOOCV, which had a better R^2 value, so created models from this train/test method
        - Explain your model
            - A Random Forest Regressor is a machine learning model that combines many decision trees to predict fish abundance from environmental variables. It captures complex, non-linear relationships, is robust to noise, and provides feature importance scores to show which predictors most influence abundance.
        - Run a test using default or standard model parameters
            - done
        - Later this week and over the next 2 weeks, we will discuss fine-tuning model parameters to generate the most accurate model
        - Now that you've run the test, what are your results and what do they mean?
            - The Random Forest model showed that bathymetry and benthic habitat cover were the most important predictors of fish abundance, while protection status had a smaller effect. However, overall model performance was weak, as shown by negative R² values and high prediction error. These results suggest that fish abundance is likely influenced by additional ecological factors not included in this model, such as fishing pressure, habitat complexity, or species interactions. Or the model still can't account for the overdispersion common in ecological data.

**Data illustration and interpretation**
- Goals for 11/24
Now that you've run through a test of your model, plot the results and describe how well it did
After discussing the initial run of your model, try and tune the model (change some parameters of your model, which is dependent on the model that you chose to do), or as an alternative, you can run a different model type on the same data and compare how well it does
Did anything change in your results? What does it mean?
Write a discussion on the final results after you've decided you've finished your analysis
 - The original Poisson regression performed very poorly, even when validated using Leave-One-Out Cross Validation (LOOCV), so I switched to a Random Forest Regressor. Model performance was evaluated using observed versus predicted scatterplots, which showed weak predictive ability. The Random Forest model produced negative R² values for both the 80/20 train-test split (−0.25) and LOOCV (−0.22), indicating it performed worse than simply predicting the mean abundance. Prediction error was high, with RMSE values of 14.16 and 14.88. Because performance did not improve with LOOCV, the poor results are likely due to limitations in the predictor variables rather than overfitting. Feature importance results showed that bathymetry and turf cover were the most influential predictors, followed by macroalgae cover and protection status. However, overall model performance remained weak, suggesting that fish abundance is influenced by additional ecological factors not captured in this dataset.

**Data presentation on Github**
- Goals for 12/1
This week should mostly be you writing up and making all of your analysis look nice on Github. Don't just blindly post AI generated code in a .ipynb file, only include the important steps and describe each step along the way with figures when needed. My final file is the **Random_forest_model_FP.ipynb**
Finally, write a page reflection on the project at the bottom of your Final Project file
How did your final project go? What results what you had hoped? How do you feel about being able to run a machine learning method? Is it simpler or harder than you thought? Could you incorporate this into other work? What worked, what didn't? What was frustrating or rewarding?
- This project helped me see both the strengths and the limits of using machine learning in ecology. I expected the environmental variables and protection status to be good predictors of fish abundance, but the model didn’t perform well and had negative R² values and high error. That was frustrating at first, but it also showed me how complex ecological systems really are and how many factors can influence abundance that aren’t always easy to measure.
Even though the model wasn’t very accurate, I gained a lot of confidence in working with data. I learned how to load and prepare my data, choose predictor variables, split the dataset, run a model, and evaluate how well it performed. Interpreting feature importance and validation results was especially useful. Machine learning ended up being more challenging than I expected, especially when the model didn’t improve with tuning or cross-validation.
Overall, this project was still really rewarding because it showed me how machine learning can be used as a tool in ecological research, even when the results aren’t perfect. I feel much more comfortable using these methods in future classes or research, and I now better understand how to think critically about model results instead of assuming the model is always right.
