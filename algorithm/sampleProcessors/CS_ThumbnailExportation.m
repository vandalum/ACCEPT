%% This file is part of ACCEPT, 
% A program for the automated classification, enumeration and 
% phenotyping of Circulating Tumor Cells.
% Copyright (C) 2016 Leonie Zeune, Guus van Dalum, Christoph Brune
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%% 
classdef CS_ThumbnailExportation < SampleProcessor
    % CS_ThumbnailExportation - exports all thumbnails that are stored as
    % scored prior locations in the xml or xls file.
        
    properties
    end
    
    methods 
        function this = CS_ThumbnailExportation()
            this.name = 'CS Thumbnail Exportation';
            this.version = '0.1'; 
            this.dataframeProcessor =[];
            this.pipeline = cell(0);
            this.showInList = false;
        end
        
        function run(this,inputSample)
            IO.save_thumbnail(inputSample,[],'prior',false);
        end
        
        
    end
end