function y = runFzPI(e, De, KI, KP, KE, flc, T)
    %normalize inputs
    e = e/50;
    De = DE/100;
    %find Ti=a
    Ti = KP/KI;
    
    
    
    %TODO fix f{} function
    F=2999999;
    
    
    
    K = KP/F;
    KD = a*KE;
    %apply gains
    e = KE*e;
    De = KD*De;
    De = De/T;
    %limit e,De to -1,1
    e = limit(e);
    De = limit(De);
    %calculate output of the controller
    y = evalfis([e De],flc);
    %fix output to the model
    y = y*T;    %sample time
    y = K*y;    %apply gain
    y = y*50;   %denormalize
    
end


function out = limit(in)
    if in>1
        out = 1;
    elseif in<-1
        out = -1;
    else
        out = in;
    end
    
end