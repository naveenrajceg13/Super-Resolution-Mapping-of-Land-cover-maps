function [fn]=mapwindow()

[filename, pathname]=uigetfile('*.*','Select a image');
  if isequal(filename,0) || isequal(pathname,0)
      fn=0;
  else
      fn = fullfile(pathname, filename);
  end
  
  