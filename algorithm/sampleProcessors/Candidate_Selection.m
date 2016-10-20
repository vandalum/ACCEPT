classdef Candidate_Selection < SampleProcessor
%CTC_Marker_Characterization SampleProcessor for the Feature Collection use case.
    % Acts on preselected thumbnails, does segmentation (otsu thresholding)
    % an extracts features for every cell. No classification!
        
    properties
    end
    
    methods 
        function this = Candidate_Selection(io)
            this.name = 'Candidate Selection';
            this.version = '0.1';
            this.io = io;  
            this.dataframeProcessor = DataframeProcessor('FullImage_Detection', this.make_dataframe_pipeline(),'0.1');
            this.pipeline = this.make_sample_pipeline();
        end
        
        function run(this,inputSample)
%             gui = gui_manual_gates();
%             waitfor(gui.fig_main,'UserData')
%             gates = get(gui.fig_main,'UserData');
%             delete(gui.fig_main)
%             clear('gui');
%             
%             this.pipeline{4}.gates = gates;
            
            this.pipeline{1}.run(inputSample);
            this.pipeline{2}.run(inputSample);
            lambda          = 0.01;
            inner_it        = 200;
            breg_it         = 1;
            init            = {'triangle','global', inputSample.histogram_down};
            maskForChannels = [];
            single_ch       = []; %3;
            use_openMP      = true;
            ac = ActiveContourSegmentation(lambda,inner_it,breg_it,init,...
                                           maskForChannels,single_ch,use_openMP);
            ac.clear_border = 1;
            this.dataframeProcessor.pipeline{1} = ac;
            for i = 3:numel(this.pipeline)
                this.pipeline{i}.run(inputSample);
            end  
            this.io.save_thumbnail(inputSample,[],[],[],1);
            this.io.save_results_as_xls(inputSample);
        end
        
        function pipeline = make_sample_pipeline(this)
            pipeline = cell(0);
           
            sol = SampleOverviewLoading();
            md = MaskDetermination();
            fc = FeatureCollection(this.dataframeProcessor,this.io);    
            mc = ManualClassification(cell(0),'ManualGates');
            
            pipeline{1} = sol;
            pipeline{2} = md;
            pipeline{3} = fc;
            pipeline{4} = mc;
        end
    end
    
    methods (Static)    
        function pipeline = make_dataframe_pipeline()
            pipeline = cell(0);
            ef = ExtractFeatures();      
            pipeline{1} = [];
            pipeline{2} = ef;
        end     
    end
    
end