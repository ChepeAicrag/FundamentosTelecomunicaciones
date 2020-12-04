classdef TrabajoUnidad < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        GridLayout                      matlab.ui.container.GridLayout
        LeftPanel                       matlab.ui.container.Panel
        GARCAGARCAJOSNGELSANTIAGOSOLANODAFNELabel  matlab.ui.control.Label
        RightPanel                      matlab.ui.container.Panel
        GridLayout2                     matlab.ui.container.GridLayout
        UIAxes                          matlab.ui.control.UIAxes
        UIAxes2                         matlab.ui.control.UIAxes
        Panel                           matlab.ui.container.Panel
        PARMETROSDELASEALANALGICALabel  matlab.ui.control.Label
        AmplitudVEditFieldLabel         matlab.ui.control.Label
        AmplitudVEditField              matlab.ui.control.NumericEditField
        FaseLabel                       matlab.ui.control.Label
        FaseEditField                   matlab.ui.control.NumericEditField
        FrecuenciaHzEditFieldLabel      matlab.ui.control.Label
        FrecuenciaHzEditField           matlab.ui.control.NumericEditField
        PARMETROSDELASEALDIGITALLabel   matlab.ui.control.Label
        GraficarATButton                matlab.ui.control.Button
        BorrarButton                    matlab.ui.control.Button
        TasadebitbpsLabel               matlab.ui.control.Label
        TasadebitbpsEditField           matlab.ui.control.NumericEditField
        TrendebitsEditFieldLabel        matlab.ui.control.Label
        TrendebitsEditField             matlab.ui.control.EditField
        IntervalodebitsLabel            matlab.ui.control.Label
        IntervalodebitsEditField        matlab.ui.control.NumericEditField
        GraficarAFButton                matlab.ui.control.Button
        PeriodosEditFieldLabel          matlab.ui.control.Label
        PeriodosEditField               matlab.ui.control.EditField
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: GraficarATButton
        function GraficarATButtonPushed(app, event)
            % Ajustamos las dos gráficas
            LimpiarGraficas(app, event)
            
            % GRÁFICA DE SEÑAL ANALÓGICA
            a = app.AmplitudVEditField.Value; % Recuperamos la amplitud en V
            per = app.PeriodosEditField.Value; % Recuperamos el periodo en s
            
            if per == '0' % Verificamos si es una señal analógica con periodo de 0.
                a_2 = a * 2;
                app.UIAxes.YLim = [-a_2 a_2];
                app.UIAxes.YTick = [ -a_2 : 1 : a_2];
                app.UIAxes.YTickLabel = { -a_2 : a_2};
                titulo =  [ 'Señal Analógica con Periodo = ' per ' s    Frecuencia = 0 Hz    Amplitud = ' int2str( a ) ' V'];
                title( app.UIAxes,titulo ); % Colocamos el titulo 
                rectangle(app.UIAxes,'Position',[0 0 1 a],"FaceColor",'r'); % Graficamos si la señal es analógica y de peiodo 0.
            else
                fraccion = strsplit( per, '/' );
                p = str2double( fraccion( 1 ) ) / str2double(fraccion( 2 ) ); % Mapeamos el periodo a decimales
                g = app.FaseEditField.Value; % Recuperamos los grados para la fase
                f = 1 / p; % Calculamos la frecuencia en hz
                titulo =  [ 'Señal Analógica con Periodo = ' per ' s    Frecuencia = ' int2str( f ) ' Hz    Amplitud = ' int2str( a ) ' V    Fase = ' int2str( g ) ' grados' ];
                title( app.UIAxes,titulo ); % Colocamos el titulo 
                T = [ 0 : 1 / ( f * 32 ) : 1]; % Vector tiempo
                y = a * sin( 2 * pi * f * T + (g * pi / 180) ); % Función senoidal para la señal
                
                % Modificamos la grafica para que se vea adaptada a nuestros parametros.
                app.FrecuenciaHzEditField.Value = f; % Mostramos la frecuencia calculada
                app.UIAxes.YLim = [-a a];
                app.UIAxes.YTick = [ -a : 1 : a];
                app.UIAxes.YTickLabel = { -a : a};
                plot( app.UIAxes, T, y, '-r'); % Graficamos la señal analógica con periodo diferente de 0
            end
            
            % GRAFICA DE SEÑAL DIGITAL
            GraficarDigital( app, event);
            
        end

        % Button pushed function: BorrarButton
        function BorrarCampos(app, event)
            % Limpiamos los campos de parametros y las graficas
            LimpiarGraficas(app, event);
            app.AmplitudVEditField.Value = 0;
            app.PeriodosEditField.Value = '0';
            app.FaseEditField.Value = 0;
            app.FrecuenciaHzEditField.Value = 0;
            app.TrendebitsEditField.Value = ' ';
            app.IntervalodebitsEditField.Value = 0;
            app.TasadebitbpsEditField.Value = 0;
        end

        % Callback function
        function LimpiarGraficas(app, event)
            % Limpiamos las graficas
            app.UIAxes.reset;
            cla( app.UIAxes );
            title( app.UIAxes, 'Señal Analógica' );
            xlabel( app.UIAxes, 'Tiempo (s)' );
            ylabel( app.UIAxes, 'Amplitud (V)' );
            app.UIAxes2.reset;
            cla( app.UIAxes2);
            title( app.UIAxes2,'Señal Digital' );
            xlabel( app.UIAxes2, 'Tiempo (s)' );
            ylabel( app.UIAxes2, 'Amplitud (V)' );
        end

        % Button pushed function: GraficarAFButton
        function GraficarAFButtonPushed(app, event)
            % Ajustamos las graficas
            LimpiarGraficas(app, event)
            xlabel( app.UIAxes, 'Frecuencia (hz)' );
            ylabel( app.UIAxes, 'Amplitud (V)' );
            
            % GRÁFICA DE SEÑAL ANALÓICA CON DOMIO DE FRECUENCIA
            a = app.AmplitudVEditField.Value; % Recuperamos la amplitud en V
            per = app.PeriodosEditField.Value; % Recuperamos el periodo en s

            if per ~= '0' % Verificamos si se trata de una señal analógica con periodo de 0
                fraccion = strsplit( per, '/' );
                p = str2double( fraccion( 1 ) ) / str2double(fraccion( 2 ) ); % Mapeamos el periodo a decimales
                f = 1 / p; % Calculamos la frecuencia en hz
                app.UIAxes.XLim = [ 0 f + 1 ];
                app.UIAxes.XTick = [ 0 : 1 : f + 1 ];
                app.UIAxes.XTickLabel = { 0 : f + 1 };
            else
                f = 0; % Asignamos frecuencia de 0 si el periodo es 0.
            end
            a_2 = a + 5;
            app.FrecuenciaHzEditField.Value = f; % Mostramos la frecuencia calculada
            titulo =  [ 'Señal Analógica con Periodo = ' per ' s    Frecuencia = ' int2str( f ) ' Hz    Amplitud = ' int2str( a ) ' V' ];
            title( app.UIAxes,titulo ); % Colocamos el titulo 
            bar(app.UIAxes, f, a, 'g'); % Graficamos la señal analógica en el dominio de frecuencia
            app.UIAxes.YLim = [-1 a_2 ];
            app.UIAxes.YTick = [ -1 : 1 : a_2 ];
            app.UIAxes.YTickLabel = { -1 : a_2 };
            % GRAFICA DE SEÑAL DIGITAL
            GraficarDigital( app, event); 
        end

        % Callback function
        function GraficarDigital(app, event)
            % GRAFICA DE SEÑAL DIGITAL
            entrada_tren = app.TrendebitsEditField.Value; % Recuperamos el tren de bits
            elementAdd = [' ' entrada_tren( end ) ];
            entrada_tren_2 = [ entrada_tren elementAdd ];
            tbits = str2num( entrada_tren_2 ); % Mapeamos el string de tren de bits a una matriz de 1 y 0
            ib = 1 / length( strrep( entrada_tren,' ','') ); % Calculamos el intervalo de bit
            tsb = 1 / ib; % Calculamos la tasa de bits
            T_2 = [ 0 : ib : 1 ]; % Vector tiempo
            title( app.UIAxes2, [ 'Señal Digital del Tren de Bits [ ' entrada_tren  ' ] con Intervalo de bit = ' num2str( ib ) ' s y Tasa de bits = ' int2str( tsb ) ' bps'] );
            app.IntervalodebitsEditField.Value = ib; % Mostramos el intervalo de bit
            app.TasadebitbpsEditField.Value = tsb; % Mostramos la tasa de bits
            stairs( app.UIAxes2, T_2,tbits, '-m'); % Graficamos la matriz de tren de bits
            app.UIAxes2.YLim = [ -1 2 ];
            app.UIAxes2.YTick = [ -1 : 1 : 2];
            app.UIAxes2.YTickLabel = { -1 : 2 };
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {647, 647};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {44, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 1448 647];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {44, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.BackgroundColor = [0.2078 0.7059 0.8314];
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;
            app.LeftPanel.FontAngle = 'italic';

            % Create GARCAGARCAJOSNGELSANTIAGOSOLANODAFNELabel
            app.GARCAGARCAJOSNGELSANTIAGOSOLANODAFNELabel = uilabel(app.LeftPanel);
            app.GARCAGARCAJOSNGELSANTIAGOSOLANODAFNELabel.HorizontalAlignment = 'center';
            app.GARCAGARCAJOSNGELSANTIAGOSOLANODAFNELabel.FontWeight = 'bold';
            app.GARCAGARCAJOSNGELSANTIAGOSOLANODAFNELabel.FontAngle = 'italic';
            app.GARCAGARCAJOSNGELSANTIAGOSOLANODAFNELabel.Position = [4.5 4 37 637];
            app.GARCAGARCAJOSNGELSANTIAGOSOLANODAFNELabel.Text = {'G'; 'A'; 'R'; 'C'; 'Í'; 'A'; ' '; 'G'; 'A'; 'R'; 'C'; 'Í'; 'A '; ''; 'J'; 'O'; 'S'; 'É'; ' '; 'Á'; 'N'; 'G'; 'E'; 'L'; '------'; 'S'; 'A'; 'N'; 'T'; 'I'; 'A'; 'G'; 'O'; ' '; 'S'; 'O'; 'L'; 'A'; 'N'; 'O'; ' '; 'D'; 'A'; 'F'; 'N'; 'E'; ''};

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.BackgroundColor = [0.0275 0.4784 0.6902];
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.RightPanel);
            app.GridLayout2.RowHeight = {'0.4x', '1x'};
            app.GridLayout2.RowSpacing = 14.6666666666667;
            app.GridLayout2.Padding = [24.5 14.6666666666667 24.5 14.6666666666667];

            % Create UIAxes
            app.UIAxes = uiaxes(app.GridLayout2);
            title(app.UIAxes, 'Señal Analógica')
            xlabel(app.UIAxes, 'Tiempo (s)')
            ylabel(app.UIAxes, 'Amplitud (V)')
            app.UIAxes.PlotBoxAspectRatio = [1.57435897435897 1 1];
            app.UIAxes.FontName = 'Arial';
            app.UIAxes.XLim = [0 1];
            app.UIAxes.ZLim = [0 1];
            app.UIAxes.BoxStyle = 'full';
            app.UIAxes.XColor = [0.149 0.149 0.149];
            app.UIAxes.XTick = [0 0.2 0.4 0.6 0.8 1];
            app.UIAxes.XTickLabel = {'0'; '0.2'; '0.4'; '0.6'; '0.8'; '1'};
            app.UIAxes.YColor = [0.149 0.149 0.149];
            app.UIAxes.YTick = [0 0.1 0.2 0.4 0.6 0.8 1 2 3];
            app.UIAxes.YTickLabel = {'0'; '0.1'; '0.2'; '0.4'; '0.6'; '0.8'; '1'; '2'; '3'};
            app.UIAxes.BackgroundColor = [0.9294 0.8314 0.2392];
            app.UIAxes.Tag = 'grafica_digital';
            app.UIAxes.Layout.Row = 2;
            app.UIAxes.Layout.Column = 1;

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.GridLayout2);
            title(app.UIAxes2, 'Señal Digital')
            xlabel(app.UIAxes2, 'Tiempo(s)')
            ylabel(app.UIAxes2, 'Amplitud(V)')
            app.UIAxes2.PlotBoxAspectRatio = [1.6505376344086 1 1];
            app.UIAxes2.BackgroundColor = [0.9294 0.8314 0.2392];
            app.UIAxes2.Layout.Row = 2;
            app.UIAxes2.Layout.Column = 2;

            % Create Panel
            app.Panel = uipanel(app.GridLayout2);
            app.Panel.ForegroundColor = [1 0 0];
            app.Panel.TitlePosition = 'centertop';
            app.Panel.Title = 'FUNDAMENTOS DE TELECOMUNICACIONES -- GRAFICADOR DE SEÑALES ANALÓGICAS Y DIGITALES';
            app.Panel.BackgroundColor = [0.502 0.9686 0.4745];
            app.Panel.Layout.Row = 1;
            app.Panel.Layout.Column = [1 2];
            app.Panel.FontWeight = 'bold';
            app.Panel.FontSize = 15;

            % Create PARMETROSDELASEALANALGICALabel
            app.PARMETROSDELASEALANALGICALabel = uilabel(app.Panel);
            app.PARMETROSDELASEALANALGICALabel.HorizontalAlignment = 'center';
            app.PARMETROSDELASEALANALGICALabel.FontSize = 18;
            app.PARMETROSDELASEALANALGICALabel.FontWeight = 'bold';
            app.PARMETROSDELASEALANALGICALabel.FontAngle = 'italic';
            app.PARMETROSDELASEALANALGICALabel.Position = [169 98 419 57];
            app.PARMETROSDELASEALANALGICALabel.Text = 'PARÁMETROS DE LA SEÑAL ANALÓGICA';

            % Create AmplitudVEditFieldLabel
            app.AmplitudVEditFieldLabel = uilabel(app.Panel);
            app.AmplitudVEditFieldLabel.HorizontalAlignment = 'right';
            app.AmplitudVEditFieldLabel.FontSize = 14;
            app.AmplitudVEditFieldLabel.Position = [364 64 83 23];
            app.AmplitudVEditFieldLabel.Text = 'Amplitud (V)';

            % Create AmplitudVEditField
            app.AmplitudVEditField = uieditfield(app.Panel, 'numeric');
            app.AmplitudVEditField.Tag = 'etqAmplitud';
            app.AmplitudVEditField.FontSize = 14;
            app.AmplitudVEditField.Position = [462 65 100 22];

            % Create FaseLabel
            app.FaseLabel = uilabel(app.Panel);
            app.FaseLabel.HorizontalAlignment = 'right';
            app.FaseLabel.FontSize = 14;
            app.FaseLabel.Position = [157 21 56 23];
            app.FaseLabel.Text = 'Fase (°)';

            % Create FaseEditField
            app.FaseEditField = uieditfield(app.Panel, 'numeric');
            app.FaseEditField.FontSize = 14;
            app.FaseEditField.Position = [228 22 100 22];

            % Create FrecuenciaHzEditFieldLabel
            app.FrecuenciaHzEditFieldLabel = uilabel(app.Panel);
            app.FrecuenciaHzEditFieldLabel.HorizontalAlignment = 'right';
            app.FrecuenciaHzEditFieldLabel.FontSize = 14;
            app.FrecuenciaHzEditFieldLabel.Position = [342 19 105 23];
            app.FrecuenciaHzEditFieldLabel.Text = 'Frecuencia (Hz)';

            % Create FrecuenciaHzEditField
            app.FrecuenciaHzEditField = uieditfield(app.Panel, 'numeric');
            app.FrecuenciaHzEditField.Editable = 'off';
            app.FrecuenciaHzEditField.FontSize = 14;
            app.FrecuenciaHzEditField.Position = [462 20 100 22];

            % Create PARMETROSDELASEALDIGITALLabel
            app.PARMETROSDELASEALDIGITALLabel = uilabel(app.Panel);
            app.PARMETROSDELASEALDIGITALLabel.HorizontalAlignment = 'center';
            app.PARMETROSDELASEALDIGITALLabel.FontSize = 18;
            app.PARMETROSDELASEALDIGITALLabel.FontWeight = 'bold';
            app.PARMETROSDELASEALDIGITALLabel.FontAngle = 'italic';
            app.PARMETROSDELASEALDIGITALLabel.Position = [901 98 375 57];
            app.PARMETROSDELASEALDIGITALLabel.Text = 'PARÁMETROS DE LA SEÑAL DIGITAL';

            % Create GraficarATButton
            app.GraficarATButton = uibutton(app.Panel, 'push');
            app.GraficarATButton.ButtonPushedFcn = createCallbackFcn(app, @GraficarATButtonPushed, true);
            app.GraficarATButton.Tag = 'btnGraficar';
            app.GraficarATButton.FontSize = 14;
            app.GraficarATButton.FontWeight = 'bold';
            app.GraficarATButton.Position = [629 86 95 23];
            app.GraficarATButton.Text = 'Graficar A/T';

            % Create BorrarButton
            app.BorrarButton = uibutton(app.Panel, 'push');
            app.BorrarButton.ButtonPushedFcn = createCallbackFcn(app, @BorrarCampos, true);
            app.BorrarButton.FontSize = 14;
            app.BorrarButton.FontWeight = 'bold';
            app.BorrarButton.Position = [642 17 68 24];
            app.BorrarButton.Text = 'Borrar';

            % Create TasadebitbpsLabel
            app.TasadebitbpsLabel = uilabel(app.Panel);
            app.TasadebitbpsLabel.HorizontalAlignment = 'right';
            app.TasadebitbpsLabel.FontSize = 14;
            app.TasadebitbpsLabel.Position = [843 19 109 27];
            app.TasadebitbpsLabel.Text = 'Tasa de bit (bps)';

            % Create TasadebitbpsEditField
            app.TasadebitbpsEditField = uieditfield(app.Panel, 'numeric');
            app.TasadebitbpsEditField.Editable = 'off';
            app.TasadebitbpsEditField.FontSize = 14;
            app.TasadebitbpsEditField.Position = [967 22 100 22];

            % Create TrendebitsEditFieldLabel
            app.TrendebitsEditFieldLabel = uilabel(app.Panel);
            app.TrendebitsEditFieldLabel.HorizontalAlignment = 'right';
            app.TrendebitsEditFieldLabel.FontSize = 14;
            app.TrendebitsEditFieldLabel.Position = [988 64 79 22];
            app.TrendebitsEditFieldLabel.Text = 'Tren de bits';

            % Create TrendebitsEditField
            app.TrendebitsEditField = uieditfield(app.Panel, 'text');
            app.TrendebitsEditField.FontSize = 14;
            app.TrendebitsEditField.Position = [1082 64 100 22];

            % Create IntervalodebitsLabel
            app.IntervalodebitsLabel = uilabel(app.Panel);
            app.IntervalodebitsLabel.HorizontalAlignment = 'right';
            app.IntervalodebitsLabel.FontSize = 14;
            app.IntervalodebitsLabel.Position = [1082 17 118 29];
            app.IntervalodebitsLabel.Text = 'Intervalo de bit (s)';

            % Create IntervalodebitsEditField
            app.IntervalodebitsEditField = uieditfield(app.Panel, 'numeric');
            app.IntervalodebitsEditField.Editable = 'off';
            app.IntervalodebitsEditField.FontSize = 14;
            app.IntervalodebitsEditField.Position = [1215 22 100 22];

            % Create GraficarAFButton
            app.GraficarAFButton = uibutton(app.Panel, 'push');
            app.GraficarAFButton.ButtonPushedFcn = createCallbackFcn(app, @GraficarAFButtonPushed, true);
            app.GraficarAFButton.FontSize = 14;
            app.GraficarAFButton.FontWeight = 'bold';
            app.GraficarAFButton.Position = [629 53 95 23];
            app.GraficarAFButton.Text = 'Graficar A/F';

            % Create PeriodosEditFieldLabel
            app.PeriodosEditFieldLabel = uilabel(app.Panel);
            app.PeriodosEditFieldLabel.HorizontalAlignment = 'right';
            app.PeriodosEditFieldLabel.Position = [148 64 65 22];
            app.PeriodosEditFieldLabel.Text = 'Periodo (s)';

            % Create PeriodosEditField
            app.PeriodosEditField = uieditfield(app.Panel, 'text');
            app.PeriodosEditField.HorizontalAlignment = 'right';
            app.PeriodosEditField.Position = [228 64 100 22];
            app.PeriodosEditField.Value = '0';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = TrabajoUnidad

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end

