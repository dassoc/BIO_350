# BIO_350
first one idk
starting out BIO350 assignments repo

IC Assignment 1: Chapter 1 of Ecology Handbook
- making a difference equation
-technical difficulties
-it worked thank god

IC_assignment 2: chapter 2 of ecology handbook
-making an exponential equation
-so many technical difficulties
just coppied enya
did matplotlib adn plotting on x and y axis

IC-in class
did a log on the previous assignmetn 
then did if for function
messed aroudn with the graph of that

IC_assignment3
created a logistic model for the chances of plants gowing after lanslide
used previous exponential model and had the AI change it by writing out what I wanted
trial and error, had to make it not run infinintly finally go the graph
then we had to acount for intraspecific competition with the shading
changed it back to an exponential model because the logistic wasnt workign and teh handbook said they were doing exponential, also just made dN_0 = 0.4 * N_0
graphed that but didnt feellike making it look nicer by limiting teh days
then to find how long it takes to even out and the total plants I had teh chatbot write the code

IC_Inclassexample2 
imported Population_Data.csv and created a graph from it
used copilot inline editor to enhance the grpah: added points, changed line color, grid lines
found the carrying capacity then added it as a dotted line on the graph

IC_assignment4
created a Lotka-volterra competition model for interspecific competion between species N graphed in IC_assignment3 and a new species M, which is threatend.
changed the code around to add for species M then used copilot to edit my graph code.
the plot shows How N keeps growing and M declines. made a description for the grpah with that
found what day M population reaches 0, which is when it is less than one because you cant have a percentage of a plant.
then added in teh competition coefficient in a markdown box to work of off next week. ansered question 3: at what point does alpha need to be for both to coexist, answer in handbook.

IC_inclassexample3
first we took teh graph from assignemtn4 and messed around to see if we could keep the threatend species, didnt matter because of carrying capacity.

after this incorborated alpha adn beta into equation.
messed around with what they equal to change graph.
learned how we could simplify the graph with x* adn y*, didnt actually incorporate that in though.

IC_assignment5
-created an SIR model for a rabies outreak in a fox population
-this went terribly teh AI wasnt writing it correctly. I tried to manually put in the equations which worked but then they werent being saved correctly
-figured out that they needed to be saved as next values and not into the current so itdidntjust return the original number over and over
-plot isnt fancy becasue I didnt have time to mess around with it.
-used the plot to answer some questions on beta and d changes

- Downloaded an R.code file and imported it into VScode
- Used Copilot to troubleshoot problems downoading the scipy package
- Then copy and pasted the sections of data in and translated it to python using Copilot
- This created the multiple graphs above. The first set of plots are the genral ones for small, medium, and large populations and the rest integrate different variables in.

IC_assignment6
-ccreated an age structured model for a beetle popultation wiht and without traps
-first established the values of the matrices of F, S, and T beetle ages and inital populations.
-used a Leslie matrix on them and converted the output values to a numpy array to make them easier to work with.
-then plotted the to graphs to visualize growth differences.
-without traps= exponential growth. with traps= decline towards extinction.

Review of analysis presentation concepts:

Biological Analysis
-Amplicon Sequencing vs. Whole Genome Sequencing: Amplicon sequencing targets specific DNA regions, such as 16S rRNA genes, to study microbial diversity or specific gene variations. Whole genome sequencing (WGS), in contrast, sequences the entire genetic material of an organism, providing a comprehensive view of its genome. Amplicon sequencing is more cost-effective and focused, while WGS offers more detailed information. The choice between them depends on research goals, data needs, and resources.
-DNA Barcoding: DNA barcoding is a method of identifying species using a short, standardized DNA sequence from a specific gene region. It allows rapid and accurate classification of organisms based on genetic differences. This technique is widely used in biodiversity studies, food authentication, and conservation biology. It simplifies taxonomy by providing a genetic “barcode” for each species.
-Diversity Metrics - Alpha vs. Beta Diversity Metrics: Alpha diversity measures the number and evenness of species within a single sample or community. Beta diversity compares differences in species composition between multiple samples or environments. These metrics help scientists assess biodiversity and ecological relationships. Together, they provide insights into how species are distributed across ecosystems.

Data Analysis
-Extrapolation/Normalizing Data: Normalization adjusts data to a common scale, removing biases or differences caused by varying measurement conditions. It allows for fair comparisons between samples or datasets that might differ in size or sequencing depth. Extrapolation, on the other hand, extends existing data trends to make predictions beyond the observed range. These processes are often necessary when combining or comparing datasets from different experiments. Together, they help ensure accurate, consistent, and meaningful results in data analysis.
-Lag Analysis: Lag analysis examines delayed relationships between variables over time. It helps identify how one factor influences another after a certain time lag, such as environmental changes affecting populations later. This method is useful in time-series and ecological data analysis. It provides insights into cause-and-effect patterns that are not immediate.

Modeling Concepts
-Generalized Mixed Effect Model: Predicts how multiple factors influence a response variable while controlling for random effects. It can handle non-normal response variables, such as counts or binary data. GLMMs are useful for repeated measures or grouped data where observations are not independent. They increase model flexibility and accuracy in biological research.
-Linear Mixed Effect Model: A linear mixed effect model (LMM) is a statistical approach that incorporates both fixed and random effects for data with hierarchical or repeated measures. It assumes a linear relationship between variables. LMMs account for variability among subjects or groups, improving the reliability of results. They are commonly used in longitudinal or experimental studies.
-Allometric Scale Model: An allometric scaling model describes how biological traits change in proportion to body size. It often uses power-law relationships to explain growth, metabolism, or physiological rates across species. These models reveal predictable patterns in biology, such as how metabolism scales with mass. They are essential in ecology, physiology, and evolutionary biology.
-Linear vs. Logistic Regression: Linear regression models the relationship between variables with a continuous dependent outcome. Logistic regression, on the other hand, predicts categorical outcomes such as presence or absence. Both are used to find associations between independent and dependent variables. The choice depends on the type of data and research question.
-Non-linear Regression: Non-linear regression fits models where the relationship between variables is not a straight line. It can describe complex biological processes, such as enzyme kinetics or population growth. This method requires iterative fitting and is more computationally intensive than linear regression. It provides better accuracy for naturally curved or exponential patterns.
-Random Forests: Random forests are machine learning algorithms that build multiple decision trees and combine their results for improved accuracy. They handle large, complex datasets and can identify which variables are most important for prediction. Random forests reduce overfitting and perform well on both classification and regression tasks. They are widely used in genomics, ecology, and environmental modeling.
-Cross-Validation and Accuracy of Models: Cross-validation is a technique for testing how well a statistical or machine learning model generalizes to new data. It involves dividing data into training and testing sets to evaluate performance. This process helps detect overfitting and ensures model reliability. Accuracy metrics from cross-validation indicate how trustworthy the model’s predictions are.
