function fis=ANFISTrain(fis,data)
    x=data.TrainInputs;
    t=data.TrainTargets;
    train_Epoch=80;
    train_ErrorGoal=0;
    train_InitialStepSize=1.1;
    train_StepSizeDecrease=0.9;
    train_StepSizeIncrease=1.1;
    TrainOptions=[train_Epoch train_ErrorGoal train_InitialStepSize train_StepSizeDecrease train_StepSizeIncrease];
    display_Info=false;
    display_Error=false;
    display_StepSize=false;
    display_Final=false;
    DisplayOptions=[display_Info display_Error display_StepSize display_Final];
    OptMethod.Backpropagation=0;
    fis=anfis([x t],fis,TrainOptions,DisplayOptions,[],OptMethod.Backpropagation);
end