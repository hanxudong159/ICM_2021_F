# ICM_2021_F

This work is about to solve the F problem of ICM 2021.

## Summary

In the past 40 years, the development of higher education has been widely concerned around the world, which has played a negligible roll in all society fields. In this paper, a suite of models to easily and directly assess the health and sustainability level of any nation’s higher education system are built, in view of both current condition and development tendency. The higher education systems of Brazil, China, Japan, South Africa and the United States are evaluated as examples.
Firstly, 10 indicators involved in three aspects of Equity, Investment and Quality are selected to help build the health and sustainability evaluation model, particularly, we define the geographical distribution with Lorenz Curve and Gini Index as analog to discuss the relationship among higher education equity, administrative region and population. By using Principal Component Analysis (PCA) method, the ten indicators are processed and simplified into 3 principal components, with each representing one of the three aspects. Furthermore, Back Propagation (BP) Neural Network is introduced into the model with the 3 principle components as input layer nodes and a total evaluation level as the output layer node. For lack of reality data, 1500 random number groups signed with a grading mechanism is used as the standard training set. Though with the advantage of rich data tolerance, performance of BP neural network shows slow processing speed and low precision. The further improvement of the neural network model by using of Genetic Algorithm helps gain better performance in convergence. So far we gain a successfully trained evaluation model together with the evaluated health level of the five nations’ higher education system.
![image](https://github.com/hanxudong159/ICM_2021_F/blob/main/Figure/Fig.%20BP%20neural%20network.jpg)
Secondly, in this paper, time series analysis is used to predict the future of higher education of the five nations in the next three years. The ARIMA model was introduced to predict changes in the next three years based on three indicators for five countries within five years. Then the prediction results are input to the health evaluation model, so that the health status of the higher education system of each country three years later can be inferred, which can be regarded as its sustainability.
Thirdly, this paper takes Brazil’s higher education system as an case study. Based on the analysis using the above model, Brazil is rated as Level 1 in both health and sustainability, with considerable room for improvement. Considering with the student-to-staff ratio and employment rate, which have the greatest impact on the results, and combining with the current economic background and the status quo of higher education system in Brazil, we put forward several effective reform measures, which can raise the health level of Brazil’s higher education system to 2 or even 3, with obvious effects. This prediction result is based on the previously constructed model. Of course, in reality, the nation’s industrial structure, existing education system and concepts will all have an impact on the prediction of the effect of measures, which will be discussed in this paper.
Finally, we analyze the performance and the sensitivity of the model, which prove that our model is stable under different situations.

## Document Explanation
- **Code**: contains all the code used in the work, such as BP nerual network
- **Figure**: contains all the figures used to explain the process and results
- **Table**: contains the tables used in PCA
- **2021_ICM_Problem_F**: the problem document provided by authority
- **2126835.pdf**: the final report
