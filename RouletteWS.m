function i=RouletteWS(P)
    r=rand; 
    c=cumsum(P);
    i=find(r<=c,1,'first');
end