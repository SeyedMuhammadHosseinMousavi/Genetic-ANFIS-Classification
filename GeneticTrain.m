function [bestfis results]=GeneticTrain(fis,data)

    %% Problem Definition
    p0=FISParameters(fis);  
    Problem.CostFunction=@(x) FISCost(x,fis,data);    
    Problem.nVar=numel(p0);    
    alpha=1;
    Problem.VarMin=-(10^alpha);
    Problem.VarMax=10^alpha;

    % GA Params
    Params.MaxIt=25;
    Params.nPop=7;

    % Run GA 
    results=RunGA(Problem,Params);
    
    % Get Results
    p=results.BestSol.Position.*p0;
    bestfis=FISSet(fis,p);
    
end
function results=RunGA(Problem,Params)

    disp('Genetic Algorithm is Started');

    % Problem Definition
    CostFunction=Problem.CostFunction;        % Cost Function
    nVar=Problem.nVar;          % Number of Decision Variables
    VarSize=[1 nVar];           % Size of Decision Variables Matrix
    VarMin=Problem.VarMin;      % Lower Bound of Variables
    VarMax=Problem.VarMax;      % Upper Bound of Variables

    % GA Parameters
    MaxIt=Params.MaxIt;      % Maximum Number of Iterations

    nPop=Params.nPop;        % Population Size
    pc=0.7;                 % Crossover Percentage
    nc=2*round(pc*nPop/2);  % Number of Offsprings (Parnets)
    pm=0.5;                 % Mutation Percentage
    nm=round(pm*nPop);      % Number of Mutants
    gamma=0.2;
    mu=0.1;         % Mutation Rate
    beta=8;         % Selection Pressure

    % Initialization

    empty_individual.Position=[];
    empty_individual.Cost=[];

    pop=repmat(empty_individual,nPop,1);

    for i=1:nPop

        % Initialize Position
        if i>1
            pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
        else
            pop(i).Position=ones(VarSize);
        end
        % Evaluation
        pop(i).Cost=CostFunction(pop(i).Position);

    end

    % Sort Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);

    % Store Best Solution
    BestSol=pop(1);

    % Array to Hold Best Cost Values
    BestCost=zeros(MaxIt,1);

    % Store Cost
    WorstCost=pop(end).Cost;
    % Main 

    for it=1:MaxIt

        P=exp(-beta*Costs/WorstCost);
        P=P/sum(P);

        % Crossover
        popc=repmat(empty_individual,nc/2,2);
        for k=1:nc/2
            % Select Parents Indices
            i1=RouletteWS(P);
            i2=RouletteWS(P);
            % Select Parents
            p1=pop(i1);
            p2=pop(i2);
            % Apply Crossover
            [popc(k,1).Position, popc(k,2).Position]=...
                Crossover(p1.Position,p2.Position,gamma,VarMin,VarMax);
            % Evaluate Offsprings
            popc(k,1).Cost=CostFunction(popc(k,1).Position);
            popc(k,2).Cost=CostFunction(popc(k,2).Position);

        end
        popc=popc(:);
        % Mutation
        popm=repmat(empty_individual,nm,1);
        for k=1:nm

            % Select Parent
            i=randi([1 nPop]);
            p=pop(i);
            % Apply Mutation
            popm(k).Position=Mutate(p.Position,mu,VarMin,VarMax);
            % Evaluate Mutant
            popm(k).Cost=CostFunction(popm(k).Position);
        end

        % Create Merged Population
        pop=[pop
             popc
             popm]; 

        % Sort Population
        Costs=[pop.Cost];
        [Costs, SortOrder]=sort(Costs);
        pop=pop(SortOrder);

        % Update Worst Cost
        WorstCost=max(WorstCost,pop(end).Cost);

        % Truncation
        pop=pop(1:nPop);
        Costs=Costs(1:nPop);
        % Store Best Solution Ever Found
        BestSol=pop(1);
        % Store Best Cost Ever Found
        BestCost(it)=BestSol.Cost;
        % Show Iteration Information
        disp(['In Iteration Number ' num2str(it) ': Highest Cost Is = ' num2str(BestCost(it))]);

    end

    disp('Genetic Algorithm is Finished');
    
    %% Results

    results.BestSol=BestSol;
    results.BestCost=BestCost;
    
end

function [y1, y2]=Crossover(x1,x2,gamma,VarMin,VarMax)

    alpha=unifrnd(-gamma,1+gamma,size(x1));
    
    y1=alpha.*x1+(1-alpha).*x2;
    y2=alpha.*x2+(1-alpha).*x1;
    
    y1=max(y1,VarMin);
    y1=min(y1,VarMax);
    
    y2=max(y2,VarMin);
    y2=min(y2,VarMax);

end

function y=Mutate(x,mu,VarMin,VarMax)

    nVar=numel(x);
    
    nmu=ceil(mu*nVar);
    
    j=randsample(nVar,nmu)';
    
    sigma=0.1*(VarMax-VarMin);
    
    y=x;
    y(j)=x(j)+sigma*randn(size(j));
    
    y=max(y,VarMin);
    y=min(y,VarMax);

end