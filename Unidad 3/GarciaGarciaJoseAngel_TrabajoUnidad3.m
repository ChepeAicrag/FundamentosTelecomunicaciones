classdef GarciaGarciaJoseAngel_TrabajoUnidad3 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        GraficaM                matlab.ui.control.UIAxes
        GraficaMD               matlab.ui.control.UIAxes
        BtnGraficar             matlab.ui.control.Button
        GarcaGarcaJosngelLabel  matlab.ui.control.Label
        Label                   matlab.ui.control.Label
        BtnBorrar               matlab.ui.control.Button
        TrendebitsLabel         matlab.ui.control.Label
        TrendebitsEditField     matlab.ui.control.EditField
    end

    
    methods (Access = private)
        
        function results = func(app, val, bits, valTrans)
            k = 1;
            l = 0.5;
            T = 0 : 0.001 : length(bits);
            for j = 1: length(T)
                y(j) = valTrans(k);
                if T(j) > l
                    k = k + 1;
                    l = l + 0.5;
                end
            end
            if val == 1
                plot(app.GraficaM, T, y, 'r');
                axis(app.GraficaM, [0 length(bits) -2 2]);            
            else
                plot(app.GraficaMD, T, y, 'r');
                axis(app.GraficaMD, [0 length(bits) -2 2]);
            end
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: BtnGraficar
        function BtnGraficarButtonPushed(app, event)
            entrada_tren = app.TrendebitsEditField.Value
            bits = str2num(entrada_tren)
            
            % Manchester
            valTrans = [];
            for i = 1 : length(bits)
                if bits(i) == 0
                    transicion = [1 -1];
                else
                    transicion = [-1 1];
                end
                valTrans = [ valTrans transicion];
            end
            func(app, 1, bits, valTrans);
            
            % Manchester Diferencial
            valTrans = []; % Arreglo de los valores de la transición
            if bits(1) == 0  % Verificamos si el primer bit es 0
                transicion = [-1 1]; % Realizamos una transición de -1 a 1
            else
                transicion = [1 -1]; % Si es 1, entonces realizamos una transición de 1 a -1
            end
            valTrans = [ valTrans transicion];
            k = 2;
            for i = 2 : length(bits)
                if bits(i) == 0
                    tran = [valTrans(k - 1) valTrans(k)];
                else
                    tran = [valTrans(k) valTrans(k - 1)];
                end
                k = k + 2;
                valTrans = [valTrans tran];
            end
            func(app, 0, bits, valTrans);
        end

        % Button pushed function: BtnBorrar
        function BtnBorrarButtonPushed(app, event)
            app.TrendebitsEditField.Value = ' ';
            app.GraficaM.clo;
            axis(app.GraficaM, [0 1 0 1]);
            app.GraficaMD.clo;
            axis(app.GraficaMD, [0 1 0 1]);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.3294 0.7608 0.9451];
            app.UIFigure.Position = [100 100 843 699];
            app.UIFigure.Name = 'MATLAB App';

            % Create GraficaM
            app.GraficaM = uiaxes(app.UIFigure);
            title(app.GraficaM, 'Manchester')
            xlabel(app.GraficaM, 'Tiempo')
            ylabel(app.GraficaM, 'Amplitud')
            app.GraficaM.FontName = 'Consolas';
            app.GraficaM.FontWeight = 'bold';
            app.GraficaM.XGrid = 'on';
            app.GraficaM.TitleFontWeight = 'normal';
            app.GraficaM.BackgroundColor = [0.9294 0.6941 0.1255];
            app.GraficaM.Position = [37 325 770 274];

            % Create GraficaMD
            app.GraficaMD = uiaxes(app.UIFigure);
            title(app.GraficaMD, {'Manchester Diferencial'; ''})
            xlabel(app.GraficaMD, 'Tiempo')
            ylabel(app.GraficaMD, 'Amplitud')
            app.GraficaMD.FontName = 'Consolas';
            app.GraficaMD.FontWeight = 'bold';
            app.GraficaMD.XGrid = 'on';
            app.GraficaMD.BackgroundColor = [0.9294 0.6941 0.1255];
            app.GraficaMD.Position = [37 31 770 272];

            % Create BtnGraficar
            app.BtnGraficar = uibutton(app.UIFigure, 'push');
            app.BtnGraficar.ButtonPushedFcn = createCallbackFcn(app, @BtnGraficarButtonPushed, true);
            app.BtnGraficar.BackgroundColor = [0.8314 0.4745 0.8314];
            app.BtnGraficar.FontName = 'Consolas';
            app.BtnGraficar.FontWeight = 'bold';
            app.BtnGraficar.Position = [664 620 69 23];
            app.BtnGraficar.Text = 'Graficar';

            % Create GarcaGarcaJosngelLabel
            app.GarcaGarcaJosngelLabel = uilabel(app.UIFigure);
            app.GarcaGarcaJosngelLabel.FontSize = 14;
            app.GarcaGarcaJosngelLabel.FontWeight = 'bold';
            app.GarcaGarcaJosngelLabel.FontAngle = 'italic';
            app.GarcaGarcaJosngelLabel.Position = [632 1 175 22];
            app.GarcaGarcaJosngelLabel.Text = 'García García José Ángel';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontName = 'Consolas';
            app.Label.FontSize = 14;
            app.Label.FontWeight = 'bold';
            app.Label.FontAngle = 'italic';
            app.Label.Position = [1 673 842 24];
            app.Label.Text = 'Fundamentos de Telecomunicaciones - Graficador de Submodulación de Polar Manchester y Manchester Diferencial';

            % Create BtnBorrar
            app.BtnBorrar = uibutton(app.UIFigure, 'push');
            app.BtnBorrar.ButtonPushedFcn = createCallbackFcn(app, @BtnBorrarButtonPushed, true);
            app.BtnBorrar.BackgroundColor = [0.898 0.9294 0.298];
            app.BtnBorrar.FontName = 'Consolas';
            app.BtnBorrar.FontWeight = 'bold';
            app.BtnBorrar.Position = [740 620 67 23];
            app.BtnBorrar.Text = 'Borrar';

            % Create TrendebitsLabel
            app.TrendebitsLabel = uilabel(app.UIFigure);
            app.TrendebitsLabel.HorizontalAlignment = 'right';
            app.TrendebitsLabel.FontName = 'Consolas';
            app.TrendebitsLabel.FontSize = 14;
            app.TrendebitsLabel.FontWeight = 'bold';
            app.TrendebitsLabel.Position = [37 619 105 23];
            app.TrendebitsLabel.Text = 'Tren de bits:';

            % Create TrendebitsEditField
            app.TrendebitsEditField = uieditfield(app.UIFigure, 'text');
            app.TrendebitsEditField.HorizontalAlignment = 'center';
            app.TrendebitsEditField.FontName = 'Consolas';
            app.TrendebitsEditField.FontSize = 14;
            app.TrendebitsEditField.FontWeight = 'bold';
            app.TrendebitsEditField.Position = [157 620 500 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = GarciaGarciaJoseAngel_TrabajoUnidad3

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