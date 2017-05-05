function Ojaghi_A_Main
% SIMPLE_GUI2 Select a data set from the pop-up menu, then
% click one of the plot-type push buttons. Clicking the button
% plots the selected data in the axes.

   %  Create and then hide the UI as it is being constructed.
   f = figure('Visible','off','Position',[60,50,950,585]);
   
   %  Construct the components.
   % Making the Next Button
   hnext = uicontrol('Style','pushbutton','String','Next',...
           'Position',[825,520,70,25],'Callback',@nextbutton_Callback);
   % Making the Reset Button
   hreset = uicontrol('Style','pushbutton','String','Reset',...
           'Position',[825,480,70,25],'Callback',@resetbutton_Callback);
   htext  = uicontrol('Style','text','String','Clinical Endpoint (Kidney Cancer)',...
           'Position',[825,400,80,45]);
hpopup = uicontrol('Style','popupmenu',...
           'String',{'Tumor vs. Necrosis vs. Stroma','High vs. Low kidney grade','High vs. Low kidney survival'},...
           'Position',[825,380,70,25]);
   ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   align([hnext,hreset],'Center','None');
   casenum=0;
   % Make the UI visible.
   f.Visible = 'on';
    function nextbutton_Callback(source,eventdata)
  casenum=casenum+1;
  global a
  if casenum==1
   colors1 = [
0 0 0   % First element = black
0 0 1   % blue
0 1 0   % green
0 1 1   % cyan
1 0 0   % red
1 0 1   % purple
1 1 0   % yellow
1 1 1]; % Last element = white
% We prepare the matrix that contains the colors to be displayed
image=zeros(256,256,3);
% Circles with different Colors are made below
for i=1:256
    for k=1:256
        if((i-128)^2+(k-128)^2)<=(40^2);
            image(i,k,3)=1;
        end
        if((i-128)^2+(k-210)^2)<=(40^2);
            image(i,k,1)=1;
            image(i,k,2)=1;
            image(i,k,3)=1;
        end
        if((i-210)^2+(k-128)^2)<=(40^2);
            image(i,k,1)=1;
            image(i,k,3)=1;
        end
        if((i-210)^2+(k-46)^2)<=(40^2);
            image(i,k,2)=1;
        end
        if((i-128)^2+(k-46)^2)<=(40^2);
            image(i,k,1)=1;
        end
        if((i-46)^2+(k-128)^2)<=(40^2);
            image(i,k,1)=1;
            image(i,k,2)=1;
        end
        if((i-46)^2+(k-210)^2)<=(40^2);
            image(i,k,2)=1;
            image(i,k,3)=1;
        end
    end
end
delete(ha);
ha = axes('Units','Pixels','Position',[300,200,300,235]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
% We use the 'colormap' function to define the colors
colormap(colors1)
% We use the 'imshow' instruction to display the matrix
imagesc(image);axis off;
%RGB1.m is the function for generating the above plot
  end
  if casenum==2
   delete(ha);
   delete(htextbox);
   ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('Channels.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); % Copy import fig axes to plot
%RGB2.m is the function for generating the above plots
  end
    if casenum==3
   delete(ha);
   ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('Filters.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig);     
   %RGB3.m is the function for generating the above plots
    end
   if casenum==4
   delete(ha);
   ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('edgedetect.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig);     
   %RGB3.m is the function for generating the above plots
    end
  if casenum==5
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('Separated.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
  end
    if casenum==6
      delete(ha);
   ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'jet'
ImportFig=hgload('dcfimage.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
    if casenum==7
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
ImportFig=hgload('truncateddcf.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
    if casenum==8
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('idfcseparated.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
    if casenum==9
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('joineddfc.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
    if casenum==10
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('dfcsubtract.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
    if casenum==11
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'jet';
ImportFig=hgload('fftseparated.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
      if casenum==12
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
ImportFig=hgload('truncatedfft.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
  end
    if casenum==13
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('ifftseparated.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
    if casenum==14
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('ifftjoined.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
    if casenum==15
      delete(ha);
   ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('fftsubtract.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
    switch casenum
        case 16
        delete(ha)
   ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
      colors1 = [
0 0 0   %black
1 0 0 ];
a=zeros(128,128);
imagesc(a),colormap(colors1),caxis([0 1]), axis square, title('Initial Blank image');
[x y]=ginput(1);
a(uint8(x),uint8(y))=1;
imagesc(a),colormap(colors1),caxis([0 1]), axis square,title('Initial Blank image');
drawnow update
        case 17
    delete(ha);
   ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
  D = bwdist(a);
surfc(D), colormap jet(256);
    ax.View=[150,22];
    end
      if casenum==18
   delete(ha);   
   ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
x=0:0.1:4*pi;
y=sin(x);
xlim([min(x(:)) max(x(:))])
ylim([min(y(:)) max(y(:))])
for k = 1:numel(x)
    plot(x(k),y(k),'o','MarkerEdgeColor','r') %// Choose your own marker here
    set(gca,'Color','k');
    set(gca,'XTickLabel',[]);
    set(gca,'XTick',[]);
    set(gca,'xcolor','w');
    set(gca,'YTickLabel',[]);
    set(gca,'YTick',[]);
    set(gca,'ycolor','w'); 
    hold on
    %// MATLAB pauses for 0.01 sec before moving on to execue the next 
    %%// instruction and thus creating animation effect
    pause(0.01); 
    m(k)=getframe;
end
v=VideoWriter('sinusoid.avi', 'Uncompressed AVI'); %.AVI File named "sinusoid.avi" is saved in the directory
open(v);
writeVideo(v,m);
close(v);
% userinput.m is the file for generating the plot and the movie file
      end
    if casenum==19
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('glcmcontr.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
        if casenum==20
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
ImportFig=hgload('glcmcorrel.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
        end
        if casenum==21
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('glcmenerg.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
        end
        if casenum==22
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('glcmhomog.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
        end
        if casenum==23
      delete(ha);
         ha = axes('Units','Pixels','Position',[50,20,700,535]);
   ax = gca;
   ax.XColor = 'none';
   ax.YColor = 'none';
   colormap 'gray';
ImportFig=hgload('glcmentrop.fig',struct('visible','off')); % Open fig file and get handle
ImportFigAxes=get(ImportFig,'Children');          % Get handle to axes
% Get plot axes info
NewFig=get(ha,'Parent');           % Get new figure handle
delete(ha);                        % Delete blank plot axes
ha=copyobj(ImportFigAxes,NewFig); 
    end
    end

  function resetbutton_Callback(source,eventdata) 
  % Display mesh plot of the currently selected data.
  casenum=1;
  colors1 = [0 0 0  
0 0 1   % blue
0 1 0   % green
0 1 1   % cyan
1 0 0   % red
1 0 1   % purple
1 1 0   % yellow
1 1 1]; % Last element = white
image=zeros(256,256,3);
for i=1:256
    for k=1:256
        if((i-128)^2+(k-128)^2)<=(40^2);
            image(i,k,3)=1;
        end
        if((i-128)^2+(k-210)^2)<=(40^2);
            image(i,k,1)=1;
            image(i,k,2)=1;
            image(i,k,3)=1;
        end
        if((i-210)^2+(k-128)^2)<=(40^2);
            image(i,k,1)=1;
            image(i,k,3)=1;
        end
        if((i-210)^2+(k-46)^2)<=(40^2);
            image(i,k,2)=1;
        end
        if((i-128)^2+(k-46)^2)<=(40^2);
            image(i,k,1)=1;
        end
        if((i-46)^2+(k-128)^2)<=(40^2);
            image(i,k,1)=1;
            image(i,k,2)=1;
        end
        if((i-46)^2+(k-210)^2)<=(40^2);
            image(i,k,2)=1;
            image(i,k,3)=1;
        end
    end
end
delete(ha);
ha = axes('Units','Pixels','Position',[300,200,300,235]);
   ax = gca;
   ax.Title.String = 'Question 1.a';
   ax.XColor = 'none';
   ax.YColor = 'none';
colormap(colors1)
imagesc(image);axis off
%RGB1 is the function for generating the above plot
  end


end