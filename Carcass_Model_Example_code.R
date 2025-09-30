install.packages("deSolve")
install.packages("ggplot2")
install.packages("patchwork")
library(deSolve)
library(ggplot2)
library(patchwork)


SICZ= function(times, x, parameters){
  # Simulate SIR

  # Extract state variables
  S = x[1]
  I = x[2]
  C = x[3]
  Z = x[4]
  
  N = S+I+C
  
  
  # Extract parameters
  beta_p = parameters['beta_p']#transmission 
  beta_c = parameters['beta_c']#transmission from carcass
  beta_z = parameters['beta_z']#transmission from zoospore pool
  a = parameters['a']# disease induced death rate
  lamdaC = parameters ['lamdaC']# decay of carcass
  sigma = parameters ['sigma']# shed rate from infected
  mu = parameters ['mu']# shed rate from carcass
  lamdaZ = parameters ['lamdaZ']# decay rate of zoospores
  r= parameters ['r'] # recovery rate 
  # Differential equations
  dS = -(S*beta_p*(I/N))-(S*beta_c*C)-(S*beta_z*Z)
  dI = (S*beta_p*(I/N))+(S*beta_c*C)+(S*beta_z*Z)-(I*a)
  dC = (I*a)-(C*lamdaC)
  dZ =  (I*sigma)+(C*mu)-(Z*lamdaZ)
  
  return(list(c(dS,dI,dC,dZ)))
  
  
}



intial_cond_Large=c(S=999,I=1,C=0,Z=0)
intial_cond_Med=c(S=99,I=1,C=0,Z=0)
intial_cond_Small=c(S=9,I=1,C=0,Z=0)

str(intial_cond)
times = seq(0, 365, length=365)
params<-c("beta_p"=0.023,"beta_c"=0.023, "beta_z"= 0.0001,"lamdaC"=(1/4),"lamdaZ"=(1/21.6),"sigma"=0.001, "mu"=0.01,"a"=(1/26.5))
str(params)
resultsSICZLarge<-as.data.frame(ode(intial_cond_Large, times, SICZ, params))
resultsSICZSmall<-as.data.frame(ode(intial_cond_Small, times, SICZ, params))
resultsSICZMed<-as.data.frame(ode(intial_cond_Med, times, SICZ, params))


Plot_exp_Large<-ggplot(resultsSICZLarge)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Large Population")
Plot_exp_Large

Plot_exp_Med<-ggplot(resultsSICZMed)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Medium Population")
Plot_exp_Med

Plot_exp_Small<-ggplot(resultsSICZSmall)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Small Population")

Plot_exp_Small

(Plot_exp_Small/
Plot_exp_Med/
Plot_exp_Large)


#"d"=0.000274
#d= parameters ['d']# death rate from natural causes 

library(MASS)
fit_gamma=fitdistr(Carcass_Survival$Days.Survival,"gamma")
summary(fit_gamma)
fit_gamma
fit_exp=fitdistr(Carcass_Survival$Days.Survival,"exponential")
AIC(fit_gamma,fit_exp)
#gamma distribution is a better fit 





####Making the model gamma distributed with regard to infection class

SICZ_gamma= function(times, x, parameters){
  # Simulate SIR
  
  # Extract state variables
  S = x[1]
  I1 = x[2]
  I2 = x[3]
  I3 = x[4]
  I4 = x[5]
  I5 = x[6]
  C = x[7]
  Z = x[8]

  I = I1+I2+I3+I4+I5
  N = S+I+C
  
  
  # Extract parameters
  beta_p = parameters['beta_p']#transmission 
  beta_c = parameters['beta_c']#transmission from carcass
  beta_z = parameters['beta_z']#transmission from zoospore pool
  a = parameters['a']# disease induced death rate
  lamdaC = parameters ['lamdaC']# decay of carcass
  sigma = parameters ['sigma']# shed rate from infected
  mu = parameters ['mu']# shed rate from carcass
  lamdaZ = parameters ['lamdaZ']# decay rate of zoospores
  # Differential equations
  dS = -(S*beta_p*(I/N))-(S*beta_c*C)-(S*beta_z*Z)
  dI1 = (S*beta_p*(I/N))+(S*beta_c*C)+(S*beta_z*Z)-(5*I1*a)
  dI2 = (5*I1*a)-(5*I2*a)
  dI3 = (5*I2*a)-(5*I3*a)
  dI4 = (5*I3*a)-(5*I4*a)
  dI5 = (5*I4*a)-(5*I5*a)
  dC = (I*a)-(C*lamdaC)
  dZ =  (I*sigma)+(C*mu)-(Z*lamdaZ)
  
  return(list(c(dS,dI1,dI2,dI3,dI4,dI5,dC,dZ)))
  
  
}



intial_cond_Large=c(S=999,I1=1,I2=0,I3=0,I4=0,I5=0,C=0,Z=0)
intial_cond_Med=c(S=99,I1=1,I2=0,I3=0,I4=0,I5=0,C=0,Z=0)
intial_cond_Small=c(S=9,I1=1,I2=0,I3=0,I4=0,I5=0,C=0,Z=0)

times = seq(0, 365, length=365)
newparams<-c("beta_p"=0.023,"beta_c"=0.023, "beta_z"= 0.0001,"lamdaC"=(1/10),"lamdaZ"=(1/21.6),"sigma"=(0.001), "mu"=(0.01),"a"=(0.17/5.4))
params<-c("beta_p"=0.023,"beta_c"=0.023, "beta_z"= 0.0001,"lamdaC"=(1/4),"lamdaZ"=(1/21.6),"sigma"=(0.001), "mu"=(0.01),"a"=(0.17/5.4))

resultsSICZGammaLarge_SlowDecay<-as.data.frame(ode(intial_cond_Large, times, SICZ_gamma, newparams))
resultsSICZGammaMed_SlowDecay<-as.data.frame(ode(intial_cond_Med, times, SICZ_gamma, newparams))
resultsSICZGammaSmall_SlowDecay<-as.data.frame(ode(intial_cond_Small, times, SICZ_gamma, newparams))
resultsSICZGammaSmall_FastDecay<-as.data.frame(ode(intial_cond_Small, times, SICZ_gamma, params))
resultsSICZGammaMed_FastDecay<-as.data.frame(ode(intial_cond_Med, times, SICZ_gamma, params))
resultsSICZGammaLarge_FastDecay<-as.data.frame(ode(intial_cond_Large, times, SICZ_gamma, params))

#Large Gamma Infection Totals
totIGammaLarge_SlowDecay = resultsSICZGammaLarge_SlowDecay$I1 + resultsSICZGammaLarge_SlowDecay$I2 + resultsSICZGammaLarge_SlowDecay$I3 + resultsSICZGammaLarge_SlowDecay$I4+ resultsSICZGammaLarge_SlowDecay$I5
resultsSICZGammaLarge_SlowDecay$I = totIGammaLarge_SlowDecay

totIGammaLarge_FastDecay = resultsSICZGammaLarge_FastDecay$I1 + resultsSICZGammaLarge_FastDecay$I2 + resultsSICZGammaLarge_FastDecay$I3 + resultsSICZGammaLarge_FastDecay$I4+ resultsSICZGammaLarge_FastDecay$I5
resultsSICZGammaLarge_FastDecay$I = totIGammaLarge_FastDecay

#Med Gamma Infection Total
totIGammaMed_SlowDecay = resultsSICZGammaMed_SlowDecay$I1 + resultsSICZGammaMed_SlowDecay$I2 + resultsSICZGammaMed_SlowDecay$I3 + resultsSICZGammaMed_SlowDecay$I4+ resultsSICZGammaMed_SlowDecay$I5
resultsSICZGammaMed_SlowDecay$I = totIGammaMed_SlowDecay

totIGammaMed_FastDecay  = resultsSICZGammaMed_FastDecay$I1 + resultsSICZGammaMed_FastDecay$I2 + resultsSICZGammaMed_FastDecay$I3 + resultsSICZGammaMed_FastDecay$I4+ resultsSICZGammaMed_FastDecay$I5
resultsSICZGammaMed_FastDecay$I = totIGammaMed_FastDecay 


#Small Gamma Infection Total
totIGammaSmall_SlowDecay = resultsSICZGammaSmall_SlowDecay$I1 + resultsSICZGammaSmall_SlowDecay$I2 + resultsSICZGammaSmall_SlowDecay$I3 + resultsSICZGammaSmall_SlowDecay$I4+ resultsSICZGammaSmall_SlowDecay$I5
resultsSICZGammaSmall_SlowDecay$I = totIGammaSmall_SlowDecay

totIGammaSmall_FastDecay = resultsSICZGammaSmall_FastDecay$I1 + resultsSICZGammaSmall_FastDecay$I2 + resultsSICZGammaSmall_FastDecay$I3 + resultsSICZGammaSmall_FastDecay$I4+ resultsSICZGammaSmall_FastDecay$I5
resultsSICZGammaSmall_FastDecay$I = totIGammaSmall_FastDecay

#Large Gamma Pops
Plot_gamma_largeSlowDecay<-ggplot(resultsSICZGammaLarge_SlowDecay)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_LargePopSlowDecay")

Plot_gamma_largeSlowDecay

Plot_gamma_largeFastDecay<-ggplot(resultsSICZGammaLarge_FastDecay)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_LargePop_FastDecay")

Plot_gamma_largeFastDecay

#Medium Gamma Pops
Plot_gamma_MedSlowDecay<-ggplot(resultsSICZGammaMed_SlowDecay)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_MedPop_SlowDecay")

Plot_gamma_MedSlowDecay
Plot_gamma_MedFastDecay<-ggplot(resultsSICZGammaMed_FastDecay)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_MedPop_FastDecay")

Plot_gamma_MedFastDecay

#Small Gamma pops
Plot_gamma_Small_Slow<-ggplot(resultsSICZGammaSmall_SlowDecay)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_SmallPop_SlowDecay")
Plot_gamma_Small_Slow

Plot_gamma_Small_Fast<-ggplot(resultsSICZGammaSmall_FastDecay)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_SmallPop_FastDecay")
Plot_gamma_Small_Fast

(Plot_exp_Small|Plot_gamma_Small_Slow|Plot_gamma_Small_Fast)/
  ( Plot_exp_Med|Plot_gamma_MedSlowDecay|Plot_gamma_MedFastDecay)/
  (Plot_exp_Large|Plot_gamma_largeSlowDecay|Plot_gamma_largeFastDecay)



#####Model with Exposed class
SICZ_gamma_exposed= function(times, x, parameters){
  # Simulate SIR
  
  # Extract state variables
  S = x[1]
  E = x[2]
  I1 = x[3]
  I2 = x[4]
  I3 = x[5]
  I4 = x[6]
  I5 = x[7]
  C = x[8]
  Z = x[9]
  
  I = I1+I2+I3+I4+I5
  N = S+I+C+E
  
  
  # Extract parameters
  beta_p = parameters['beta_p']#transmission 
  beta_c = parameters['beta_c']#transmission from carcass
  beta_z = parameters['beta_z']#transmission from zoospore pool
  a = parameters['a']# disease induced death rate
  lamdaC = parameters ['lamdaC']# decay of carcass
  sigma = parameters ['sigma']# shed rate from infected
  mu = parameters ['mu']# shed rate from carcass
  lamdaZ = parameters ['lamdaZ']# decay rate of zoospores
  gamma = parameters ['gamma']#rate of latency
  # Differential equations
  dS = -(S*beta_p*(I/N))-(S*beta_c*C)-(S*beta_z*Z)
  dE = (S*beta_p*(I/N))+(S*beta_c*C)+(S*beta_z*Z)-(gamma*E)
  dI1 = (gamma*E)-(5*I1*a)
  dI2 = (5*I1*a)-(5*I2*a)
  dI3 = (5*I2*a)-(5*I3*a)
  dI4 = (5*I3*a)-(5*I4*a)
  dI5 = (5*I4*a)-(5*I5*a)
  dC = (I*a)-(C*lamdaC)
  dZ =  (I*sigma)+(C*mu)-(Z*lamdaZ)
  
  return(list(c(dS,dE,dI1,dI2,dI3,dI4,dI5,dC,dZ)))
  
  
}



intial_cond_Large_Exposed=c(S=999,E=0,I1=1,I2=0,I3=0,I4=0,I5=0,C=0,Z=0)
intial_cond_Med_Exposed=c(S=99,E=0,I1=1,I2=0,I3=0,I4=0,I5=0,C=0,Z=0)
intial_cond_Small_Exposed=c(S=9,E=0,I1=1,I2=0,I3=0,I4=0,I5=0,C=0,Z=0)

times = seq(0, 365, length=365)
newparams_Exposed<-c("beta_p"=0.023,"beta_c"=0.023, "beta_z"= 0.0001,"lamdaC"=(1/10),"lamdaZ"=(1/21.6),"sigma"=(0.001), "mu"=(0.01),"a"=(0.17/5.4),"gamma"=(1/8))
params_Exposed<-c("beta_p"=0.023,"beta_c"=0.023, "beta_z"= 0.0001,"lamdaC"=(1/4),"lamdaZ"=(1/21.6),"sigma"=(0.001), "mu"=(0.01),"a"=(0.17/5.4),"gamma"=(1/8))

resultsSICZGammaLarge_SlowDecay_Exposed<-as.data.frame(ode(intial_cond_Large_Exposed, times, SICZ_gamma_exposed, newparams_Exposed))
resultsSICZGammaMed_SlowDecay_Exposed<-as.data.frame(ode(intial_cond_Med_Exposed, times, SICZ_gamma_exposed, newparams_Exposed))
resultsSICZGammaSmall_SlowDecay_Exposed<-as.data.frame(ode(intial_cond_Small_Exposed, times, SICZ_gamma_exposed, newparams_Exposed))
resultsSICZGammaSmall_FastDecay_Exposed<-as.data.frame(ode(intial_cond_Small_Exposed, times, SICZ_gamma_exposed, params_Exposed))
resultsSICZGammaMed_FastDecay_Exposed<-as.data.frame(ode(intial_cond_Med_Exposed, times, SICZ_gamma_exposed, params_Exposed))
resultsSICZGammaLarge_FastDecay_Exposed<-as.data.frame(ode(intial_cond_Large_Exposed, times, SICZ_gamma_exposed, params_Exposed))


#Large Gamma Infection Totals
resultsSICZGammaLarge_SlowDecay_ExposedI = resultsSICZGammaLarge_SlowDecay_Exposed$I1 + 
  resultsSICZGammaLarge_SlowDecay_Exposed$I2 + 
  resultsSICZGammaLarge_SlowDecay_Exposed$I3 + 
  resultsSICZGammaLarge_SlowDecay_Exposed$I4+ 
  resultsSICZGammaLarge_SlowDecay_Exposed$I5
resultsSICZGammaLarge_SlowDecay_Exposed$I = resultsSICZGammaLarge_SlowDecay_ExposedI

resultsSICZGammaLarge_FastDecay_ExposedI = resultsSICZGammaLarge_FastDecay_Exposed$I1 + 
  resultsSICZGammaLarge_FastDecay_Exposed$I2 + 
  resultsSICZGammaLarge_FastDecay_Exposed$I3 + 
  resultsSICZGammaLarge_FastDecay_Exposed$I4+ 
  resultsSICZGammaLarge_FastDecay_Exposed$I5
resultsSICZGammaLarge_FastDecay_Exposed$I = resultsSICZGammaLarge_FastDecay_ExposedI


#Med Gamma Infection Total
resultsSICZGammaMed_FastDecay_ExposedI = resultsSICZGammaMed_FastDecay_Exposed$I1 + 
  resultsSICZGammaMed_FastDecay_Exposed$I2 + 
  resultsSICZGammaMed_FastDecay_Exposed$I3 + 
  resultsSICZGammaMed_FastDecay_Exposed$I4+ 
  resultsSICZGammaMed_FastDecay_Exposed$I5
resultsSICZGammaMed_FastDecay_Exposed$I = resultsSICZGammaMed_FastDecay_ExposedI

resultsSICZGammaMed_SlowDecay_ExposedI = resultsSICZGammaMed_SlowDecay_Exposed$I1 + 
  resultsSICZGammaMed_SlowDecay_Exposed$I2 + 
  resultsSICZGammaMed_SlowDecay_Exposed$I3 + 
  resultsSICZGammaMed_SlowDecay_Exposed$I4+ 
  resultsSICZGammaMed_SlowDecay_Exposed$I5
resultsSICZGammaMed_SlowDecay_Exposed$I = resultsSICZGammaMed_SlowDecay_ExposedI


#Small Gamma Infection Total
resultsSICZGammaSmall_SlowDecay_ExposedI = resultsSICZGammaSmall_SlowDecay_Exposed$I1 + 
  resultsSICZGammaSmall_SlowDecay_Exposed$I2 + 
  resultsSICZGammaSmall_SlowDecay_Exposed$I3 + 
  resultsSICZGammaSmall_SlowDecay_Exposed$I4+ 
  resultsSICZGammaSmall_SlowDecay_Exposed$I5
resultsSICZGammaSmall_SlowDecay_Exposed$I = resultsSICZGammaSmall_SlowDecay_ExposedI

resultsSICZGammaSmall_FastDecay_ExposedI = resultsSICZGammaSmall_FastDecay_Exposed$I1 + 
  resultsSICZGammaSmall_FastDecay_Exposed$I2 + 
  resultsSICZGammaSmall_FastDecay_Exposed$I3 + 
  resultsSICZGammaSmall_FastDecay_Exposed$I4+ 
  resultsSICZGammaSmall_FastDecay_Exposed$I5
resultsSICZGammaSmall_FastDecay_Exposed$I = resultsSICZGammaSmall_FastDecay_ExposedI


#Large Gamma Pops
Plot_gamma_largeSlowDecay_Exp<-ggplot(resultsSICZGammaLarge_SlowDecay_Exposed)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_LargePop_SlowDecay_E state")

Plot_gamma_largeSlowDecay_Exp

Plot_gamma_largeFastDecay_Exp<-ggplot(resultsSICZGammaLarge_FastDecay_Exposed)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_LargePop_FastDecay_E state")

Plot_gamma_largeFastDecay_Exp

#Med
Plot_gamma_medSlowDecay_Exp<-ggplot(resultsSICZGammaMed_SlowDecay_Exposed)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_MedPop_SlowDecay_E state")

Plot_gamma_medSlowDecay_Exp

Plot_gamma_medFastDecay_Exp<-ggplot(resultsSICZGammaMed_FastDecay_Exposed)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_MedPop_FastDecay_E state")

Plot_gamma_medFastDecay_Exp

#Small
Plot_gamma_smallSlowDecay_Exp<-ggplot(resultsSICZGammaSmall_SlowDecay_Exposed)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_SmallPop_SlowDecay_E state")

Plot_gamma_smallSlowDecay_Exp

Plot_gamma_smallFastDecay_Exp<-ggplot(resultsSICZGammaMed_FastDecay_Exposed)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_SmallPop_FastDecay_E state")

Plot_gamma_smallFastDecay_Exp

(Plot_gamma_smallSlowDecay_Exp|Plot_gamma_smallFastDecay_Exp)/
  (Plot_gamma_medSlowDecay_Exp|Plot_gamma_medFastDecay_Exp)/
  (Plot_gamma_largeSlowDecay_Exp|Plot_gamma_largeFastDecay_Exp)

#comparison plot
(Plot_gamma_smallSlowDecay_Exp|Plot_gamma_Small_Slow)/
  (Plot_gamma_medSlowDecay_Exp|Plot_gamma_MedSlowDecay)/
  (Plot_gamma_largeSlowDecay_Exp|Plot_gamma_largeSlowDecay)




###Including a recovered class
SICZ_gamma_exposed_recovered= function(times, x, parameters){
  # Simulate SIR
  
  # Extract state variables
  S = x[1]
  E = x[2]
  I1 = x[3]
  I2 = x[4]
  I3 = x[5]
  I4 = x[6]
  I5 = x[7]
  R = x[8]
  C = x[9]
  Z = x[10]
  
  I = I1+I2+I3+I4+I5
  N = S+I+C+E+R
  
  
  # Extract parameters
  beta_p = parameters['beta_p']#transmission 
  beta_c = parameters['beta_c']#transmission from carcass
  beta_z = parameters['beta_z']#transmission from zoospore pool
  a = parameters['a']# disease induced death rate
  lamdaC = parameters ['lamdaC']# decay of carcass
  sigma = parameters ['sigma']# shed rate from infected
  mu = parameters ['mu']# shed rate from carcass
  lamdaZ = parameters ['lamdaZ']# decay rate of zoospores
  gamma = parameters ['gamma']#rate of latency
  w = parameters ['w'] #loss of immunity
  lamdaI= parameters ['lamdaI']#recovery rate
  # Differential equations
  dS = -(S*beta_p*(I/N))-(S*beta_c*C)-(S*beta_z*Z)+(R*w)
  dE = (S*beta_p*(I/N))+(S*beta_c*C)+(S*beta_z*Z)-(gamma*E)
  dI1 = (gamma*E)-(5*I1*a)
  dI2 = (5*I1*a)-(5*I2*a)
  dI3 = (5*I2*a)-(5*I3*a)
  dI4 = (5*I3*a)-(5*I4*a)
  dI5 = (5*I4*a)-(5*I5*a)
  dR = (I*lamdaI)-(R*w)
  dC = (I*a)-(C*lamdaC)
  dZ =  (I*sigma)+(C*mu)-(Z*lamdaZ)
  
  return(list(c(dS,dE,dI1,dI2,dI3,dI4,dI5,dR,dC,dZ)))
  
  
}

intial_cond_Large_Exposed_Recovered=c(S=999,E=0,I1=1,I2=0,I3=0,I4=0,I5=0,R=0,C=0,Z=0)
intial_cond_Med_Exposed_Recovered=c(S=99,E=0,I1=1,I2=0,I3=0,I4=0,I5=0,R=0,C=0,Z=0)
intial_cond_Small_Exposed_Recovered=c(S=9,E=0,I1=1,I2=0,I3=0,I4=0,I5=0,R=0,C=0,Z=0)


times = seq(0, 365, length=365)
newparams_Exposed_Recovered<-c("beta_p"=0.023,"beta_c"=0.023, "beta_z"= 0.0001,"lamdaC"=(1/10),"lamdaI"=((1/30)*.09),"w"=(1/30),"lamdaZ"=(1/21.6),"sigma"=(0.001), "mu"=(0.01),"a"=((0.17/5.4)*.91),"gamma"=(1/8))
params_Exposed_Recovered<-c("beta_p"=0.023,"beta_c"=0.023, "beta_z"= 0.0001,"lamdaC"=(1/4),"lamdaI"=((1/30)*.09),"w"=(1/30),"lamdaZ"=(1/21.6),"sigma"=(0.001), "mu"=(0.01),"a"=((0.17/5.4)*.91),"gamma"=(1/8))

resultsSICZGammaLarge_SlowDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Large_Exposed_Recovered, times, SICZ_gamma_exposed_recovered, newparams_Exposed_Recovered))
resultsSICZGammaLarge_FastDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Large_Exposed_Recovered, times, SICZ_gamma_exposed_recovered, params_Exposed_Recovered))
resultsSICZGammaMed_SlowDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Med_Exposed_Recovered, times, SICZ_gamma_exposed_recovered, newparams_Exposed_Recovered))
resultsSICZGammaMed_FastDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Med_Exposed_Recovered, times, SICZ_gamma_exposed_recovered, params_Exposed_Recovered))
resultsSICZGammaSmall_SlowDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Small_Exposed_Recovered, times, SICZ_gamma_exposed_recovered, newparams_Exposed_Recovered))
resultsSICZGammaSmall_FastDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Small_Exposed_Recovered, times, SICZ_gamma_exposed_recovered, params_Exposed_Recovered))


#Large Gamma Infection Totals
resultsSICZGammaLarge_SlowDecay_Exposed_RecoveredI = resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I5
resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I = resultsSICZGammaLarge_SlowDecay_Exposed_RecoveredI

resultsSICZGammaLarge_FastDecay_Exposed_RecoveredI = resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I5
resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I = resultsSICZGammaLarge_FastDecay_Exposed_RecoveredI


#Med Gamma Infection Totals
resultsSICZGammaMed_SlowDecay_Exposed_RecoveredI = resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I5
resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I = resultsSICZGammaMed_SlowDecay_Exposed_RecoveredI

resultsSICZGammaMed_FastDecay_Exposed_RecoveredI = resultsSICZGammaMed_FastDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaMed_FastDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaMed_FastDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaMed_FastDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaMed_FastDecay_Exposed_Recovered$I5
resultsSICZGammaMed_FastDecay_Exposed_Recovered$I = resultsSICZGammaMed_FastDecay_Exposed_RecoveredI


#Small Gamma Infection Totals
resultsSICZGammaSmall_SlowDecay_Exposed_RecoveredI = resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I5
resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I = resultsSICZGammaSmall_SlowDecay_Exposed_RecoveredI

resultsSICZGammaSmall_FastDecay_Exposed_RecoveredI = resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I5
resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I = resultsSICZGammaSmall_FastDecay_Exposed_RecoveredI



#Large Gamma Pops
Plot_gamma_largeSlowDecay_Exp_Rec<-ggplot(resultsSICZGammaLarge_SlowDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_LargePopSlowDecay")

Plot_gamma_largeSlowDecay_Exp_Rec

Plot_gamma_largeFastDecay_Exp_Rec<-ggplot(resultsSICZGammaLarge_FastDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+ 
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_LargePop_FastDecay")

Plot_gamma_largeFastDecay_Exp_Rec

#Med Gamma Pops
Plot_gamma_MedSlowDecay_Exp_Rec<-ggplot(resultsSICZGammaMed_SlowDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_MedPop_SlowDecay")

Plot_gamma_MedSlowDecay_Exp_Rec

Plot_gamma_MedFastDecay_Exp_Rec<-ggplot(resultsSICZGammaMed_FastDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+
geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_MedPop_FastDecay")

Plot_gamma_MedFastDecay_Exp_Rec

#Small Gamma Pops
Plot_gamma_SmallSlowDecay_Exp_Rec<-ggplot(resultsSICZGammaSmall_SlowDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_SlowPop_SlowDecay")

Plot_gamma_SmallSlowDecay_Exp_Rec

Plot_gamma_SmallFastDecay_Exp_Rec<-ggplot(resultsSICZGammaSmall_FastDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_SlowPop_FastDecay")

Plot_gamma_SmallFastDecay_Exp_Rec



(Plot_gamma_SmallSlowDecay_Exp_Rec|Plot_gamma_SmallFastDecay_Exp_Rec)/
  (Plot_gamma_MedSlowDecay_Exp_Rec|Plot_gamma_MedFastDecay_Exp_Rec)/
  (Plot_gamma_largeSlowDecay_Exp_Rec|Plot_gamma_largeFastDecay_Exp_Rec)





newdf<-rbind(resultsSICZGammaSmall_FastDecay_Exposed_Recovered[365,],resultsSICZGammaSmall_SlowDecay_Exposed_Recovered[365,],
             resultsSICZGammaMed_FastDecay_Exposed_Recovered[365,],resultsSICZGammaMed_SlowDecay_Exposed_Recovered[365,],
             resultsSICZGammaLarge_FastDecay_Exposed_Recovered[365,],resultsSICZGammaLarge_SlowDecay_Exposed_Recovered[365,])

###Density Dependent
###Including a recovered class
SICZ_gamma_exposed_recovered_dependent= function(times, x, parameters){
  # Simulate SIR
  
  # Extract state variables
  S = x[1]
  E = x[2]
  I1 = x[3]
  I2 = x[4]
  I3 = x[5]
  I4 = x[6]
  I5 = x[7]
  R = x[8]
  C = x[9]
  Z = x[10]
  
  I = I1+I2+I3+I4+I5
  N = S+I+C+E+R
  
  
  # Extract parameters
  beta_p = parameters['beta_p']#transmission 
  beta_c = parameters['beta_c']#transmission from carcass
  beta_z = parameters['beta_z']#transmission from zoospore pool
  a = parameters['a']# disease induced death rate
  lamdaC = parameters ['lamdaC']# decay of carcass
  sigma = parameters ['sigma']# shed rate from infected
  mu = parameters ['mu']# shed rate from carcass
  lamdaZ = parameters ['lamdaZ']# decay rate of zoospores
  gamma = parameters ['gamma']#rate of latency
  w = parameters ['w'] #loss of immunity
  lamdaI= parameters ['lamdaI']#recovery rate
  # Differential equations
  dS = -(S*beta_p*(I))-(S*beta_c*C)-(S*beta_z*Z)+(R*w)
  dE = (S*beta_p*(I))+(S*beta_c*C)+(S*beta_z*Z)-(gamma*E)
  dI1 = (gamma*E)-(5*I1*a)
  dI2 = (5*I1*a)-(5*I2*a)
  dI3 = (5*I2*a)-(5*I3*a)
  dI4 = (5*I3*a)-(5*I4*a)
  dI5 = (5*I4*a)-(5*I5*a)
  dR = (I*lamdaI)-(R*w)
  dC = (I*a)-(C*lamdaC)
  dZ =  (I*sigma)+(C*mu)-(Z*lamdaZ)
  
  return(list(c(dS,dE,dI1,dI2,dI3,dI4,dI5,dR,dC,dZ)))
  
  
}

intial_cond_Large_Exposed_Recovered=c(S=999,E=0,I1=1,I2=0,I3=0,I4=0,I5=0,R=0,C=0,Z=0)
intial_cond_Med_Exposed_Recovered=c(S=99,E=0,I1=1,I2=0,I3=0,I4=0,I5=0,R=0,C=0,Z=0)
intial_cond_Small_Exposed_Recovered=c(S=9,E=0,I1=1,I2=0,I3=0,I4=0,I5=0,R=0,C=0,Z=0)


times = seq(0, 365, length=365)
newparams_Exposed_Recovered<-c("beta_p"=0.023,"beta_c"=0.023, "beta_z"= 0.0001,"lamdaC"=(1/10),"lamdaI"=((1/30)*.09),"w"=(1/30),"lamdaZ"=(1/21.6),"sigma"=(0.001), "mu"=(0.01),"a"=((0.17/5.4)*.91),"gamma"=(1/8))
params_Exposed_Recovered<-c("beta_p"=0.023,"beta_c"=0.023, "beta_z"= 0.0001,"lamdaC"=(1/4),"lamdaI"=((1/30)*.09),"w"=(1/30),"lamdaZ"=(1/21.6),"sigma"=(0.001), "mu"=(0.01),"a"=((0.17/5.4)*.91),"gamma"=(1/8))

resultsSICZGammaLarge_SlowDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Large_Exposed_Recovered, times, SICZ_gamma_exposed_recovered_dependent, newparams_Exposed_Recovered))
resultsSICZGammaLarge_FastDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Large_Exposed_Recovered, times, SICZ_gamma_exposed_recovered_dependent, params_Exposed_Recovered))
resultsSICZGammaMed_SlowDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Med_Exposed_Recovered, times, SICZ_gamma_exposed_recovered_dependent, newparams_Exposed_Recovered))
resultsSICZGammaMed_FastDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Med_Exposed_Recovered, times, SICZ_gamma_exposed_recovered_dependent, params_Exposed_Recovered))
resultsSICZGammaSmall_SlowDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Small_Exposed_Recovered, times, SICZ_gamma_exposed_recovered_dependent, newparams_Exposed_Recovered))
resultsSICZGammaSmall_FastDecay_Exposed_Recovered<-as.data.frame(ode(intial_cond_Small_Exposed_Recovered, times, SICZ_gamma_exposed_recovered_dependent, params_Exposed_Recovered))


#Large Gamma Infection Totals
resultsSICZGammaLarge_SlowDecay_Exposed_RecoveredI = resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I5
resultsSICZGammaLarge_SlowDecay_Exposed_Recovered$I = resultsSICZGammaLarge_SlowDecay_Exposed_RecoveredI

resultsSICZGammaLarge_FastDecay_Exposed_RecoveredI = resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I5
resultsSICZGammaLarge_FastDecay_Exposed_Recovered$I = resultsSICZGammaLarge_FastDecay_Exposed_RecoveredI


#Med Gamma Infection Totals
resultsSICZGammaMed_SlowDecay_Exposed_RecoveredI = resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I5
resultsSICZGammaMed_SlowDecay_Exposed_Recovered$I = resultsSICZGammaMed_SlowDecay_Exposed_RecoveredI

resultsSICZGammaMed_FastDecay_Exposed_RecoveredI = resultsSICZGammaMed_FastDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaMed_FastDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaMed_FastDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaMed_FastDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaMed_FastDecay_Exposed_Recovered$I5
resultsSICZGammaMed_FastDecay_Exposed_Recovered$I = resultsSICZGammaMed_FastDecay_Exposed_RecoveredI


#Small Gamma Infection Totals
resultsSICZGammaSmall_SlowDecay_Exposed_RecoveredI = resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I5
resultsSICZGammaSmall_SlowDecay_Exposed_Recovered$I = resultsSICZGammaSmall_SlowDecay_Exposed_RecoveredI

resultsSICZGammaSmall_FastDecay_Exposed_RecoveredI = resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I1 + 
  resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I2 + 
  resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I3 + 
  resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I4+ 
  resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I5
resultsSICZGammaSmall_FastDecay_Exposed_Recovered$I = resultsSICZGammaSmall_FastDecay_Exposed_RecoveredI



#Large Gamma Pops
Plot_gamma_largeSlowDecay_Exp_Rec_DD<-ggplot(resultsSICZGammaLarge_SlowDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_LargePop_SlowDecay_DD")

Plot_gamma_largeSlowDecay_Exp_Rec_DD

Plot_gamma_largeFastDecay_Exp_Rec_DD<-ggplot(resultsSICZGammaLarge_FastDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+ 
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_LargePop_FastDecay")

Plot_gamma_largeFastDecay_Exp_Rec_DD

#Med Gamma Pops
Plot_gamma_MedSlowDecay_Exp_Rec_DD<-ggplot(resultsSICZGammaMed_SlowDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_MedPop_SlowDecay_DD")

Plot_gamma_MedSlowDecay_Exp_Rec_DD

Plot_gamma_MedFastDecay_Exp_Rec_DD<-ggplot(resultsSICZGammaMed_FastDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_MedPop_FastDecay")

Plot_gamma_MedFastDecay_Exp_Rec_DD

#Small Gamma Pops
Plot_gamma_SmallSlowDecay_Exp_Rec_DD<-ggplot(resultsSICZGammaSmall_SlowDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+ 
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_SmallPop_SlowDecay_DD")

Plot_gamma_SmallSlowDecay_Exp_Rec_DD

Plot_gamma_SmallFastDecay_Exp_Rec_DD<-ggplot(resultsSICZGammaSmall_FastDecay_Exposed_Recovered)+geom_line(aes(x=time, y=S, color='S')) + 
  geom_line(aes(x=time,y=E,color='E'))+
  geom_line(aes(x=time, y=I, color='I'))+
  geom_line(aes(x=time,y=R,color='R'))+
  geom_line(aes(x=time, y=C, color='C'))+
  geom_line(aes(x=time, y=Z, color='Z'))+ggtitle("Gamma_SmallPop_FastDecay")

Plot_gamma_SmallFastDecay_Exp_Rec_DD



(Plot_gamma_SmallSlowDecay_Exp_Rec_DD|Plot_gamma_SmallFastDecay_Exp_Rec_DD)/
  (Plot_gamma_MedSlowDecay_Exp_Rec_DD|Plot_gamma_MedFastDecay_Exp_Rec_DD)/
  (Plot_gamma_largeSlowDecay_Exp_Rec_DD|Plot_gamma_largeFastDecay_Exp_Rec_DD)

(Plot_gamma_SmallSlowDecay_Exp_Rec|Plot_gamma_SmallSlowDecay_Exp_Rec_DD)/
  (Plot_gamma_MedSlowDecay_Exp_Rec|Plot_gamma_MedSlowDecay_Exp_Rec_DD)/
  (Plot_gamma_largeSlowDecay_Exp_Rec|Plot_gamma_largeSlowDecay_Exp_Rec_DD)





newdf<-rbind(resultsSICZGammaSmall_FastDecay_Exposed_Recovered[365,],resultsSICZGammaSmall_SlowDecay_Exposed_Recovered[365,],
             resultsSICZGammaMed_FastDecay_Exposed_Recovered[365,],resultsSICZGammaMed_SlowDecay_Exposed_Recovered[365,],
             resultsSICZGammaLarge_FastDecay_Exposed_Recovered[365,],resultsSICZGammaLarge_SlowDecay_Exposed_Recovered[365,])


