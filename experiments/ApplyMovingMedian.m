x=randn(300,1); 
  plot(x,'g.'); 
  hold on; 
  plot(moving(x,7),'k'); 
  plot(moving(x,7,'median'),'r'); 
  plot(moving(x,7,@(x)max(x)),'b'); 
  legend('x','7pt moving mean','7pt moving median','7pt moving max','location','best')