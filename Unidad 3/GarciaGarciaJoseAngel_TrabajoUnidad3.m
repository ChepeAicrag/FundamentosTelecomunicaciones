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
        ModulacinDropDownLabel  matlab.ui.control.Label
        SelMod                  matlab.ui.control.DropDown
    end

    
    methods (Access = private)
        
        function results = graficar(app, val, n, valTrans) % Funci�n para graficar
            k = 1; % Variable para recorrer el vector de transiciones de la modulaci�n
            l = 0.5; % Variable para graficar la transici�n en intervalores de 0.5
            T = 0 : 0.001 : n; % Vector de tiempo 
            for j = 1: length( T ) % Recorremos todo el vector de tiempo
                y( j ) = valTrans( k ); % Guardamos en nuestra funci�n y la transici�n correspondiente
                if T( j ) > l % Verificamos si ya tenemos que camibar de transici�n
                    k = k + 1; % Incrementamos k, as� cambiaremos de transici�n
                    l = l + 0.5; % Incrementamos l que corresponde al lugar de la otra transici�n
                end 
            end 
            if val == 1 % Verificamos si vamos a graficar una modulaci�n Manchester
                plot( app.GraficaM, T, y, 'r' ); % Graficamos nuestra funci�n de variable y
                axis( app.GraficaM, [ 0 n -2 2 ] ); % Colocamos los valares de los ejes para visualizar mejor
            else % Nos indica que graificaremos Manchester Diferencial
                plot( app.GraficaMD, T, y, 'r' ); % Graficamos nuestra funci�n de variable y
                axis( app.GraficaMD, [ 0 n -2 2 ] ); % Colocamos los valares de los ejes para visualizar mejor
            end
        end % Fin de nuestra funci�n graficar
        
        function results = Manchester(app, bits) % Funci�n para obtener transiciones de modulaci�n Manchester
            valTrans = []; % Declaramos un vector de transiciones 
            for i = 1 : length( bits ) % Recorremos nuestro tren de bits
                if bits( i ) == 0 % Verificamos si el bit actual es un 0
                    transicion = [ 1 -1 ]; % Realizamos una transici�n de poisitivo a negativo
                else % Nos indica que es un bit 1
                    transicion = [ -1 1 ]; % Realizamos una transici�n de negativo a positivo
                end
                valTrans = [ valTrans transicion]; % Agregamos la transicion al vector de transiciones
            end
            graficar( app, 1, length( bits ), valTrans ); % Graficamos mediante nuestra funci�n para graficar
        end % Fin de nuestra funci�n Manchester
        
        function results = ManchesterDiferencial(app, bits) % Funci�n para obtener transiciones de modulaci�n Manchester Diferencial
            valTrans = []; % Declaramos un vector de los valores de la transici�n
            if bits( 1 ) == 0  % Verificamos si el primer bit es 0
                transicion = [ -1 1 ]; % Realizamos una transici�n de negativo a positivo
            else % Nos indica que el bit es un 1
                transicion = [ 1 -1 ]; % Realizamos una transici�n de positivo a negativo
            end
            valTrans = [ valTrans transicion ]; % Agregamos a nuestra transici�n al vector de transiciones
            k = 2; % Declaramos una variable que nos permitir� obtener el ultimo valor de la transici�n 
            for i = 2 : length(bits) % Recorremos nuestro trend e bits
                if bits( i ) == 0 % Si el bit actual es 0
                    tran = [ valTrans( k - 1 ) valTrans( k ) ]; % Mantenemos la transici�n del bit anterior
                else % Nos indica que el bit actual es 1
                    tran = [ valTrans( k ) valTrans( k - 1 ) ]; % No hay transici�n y realizamos la inversi�n de la transici�n del bit anterior
                end
                k = k + 2; % Incrementos nuestra variable
                valTrans = [ valTrans tran ]; % Agregamos la transici�n al vector de transiciones
            end
            graficar( app, 0, length( bits ), valTrans ); % Graficamos mediante nuestra funci�n para graficar
        end
    end % Fin de nuestra funci�n Manchester Diferencial
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: BtnGraficar
        function BtnGraficarButtonPushed(app, event)
            entrada_tren = app.TrendebitsEditField.Value; % Obtenemos el tren de bits como string
            bits = str2num( entrada_tren ); % Mapeamos ese tren de bits de string a una matriz de 1 y 0
            op = app.SelMod.Value; % Obtenemos que modulaci�n aplicar
            BtnBorrarButtonPushed( app, event ); % Borramos todos los campos
            app.TrendebitsEditField.Value = entrada_tren; % Colocamos nuestros campo de tren de bits                    
            if strcmpi( op, 'Manchester' ) % Verificamos si aplicaremos Manchester 
                Manchester( app, bits ); % Ejecutamos la modulaci�n de Manchester
            elseif strcmpi( op,'Ambas' ) % Verificamos si aplicaremos ambas modulaciones
                ManchesterDiferencial( app, bits ); % Ejecutamos la modulaci�n de Manchester Diferencial
                Manchester( app, bits ); % Ejecutamos la modulaci�n de Manchester
            else % Si no fue ninguna de las anteriores, entonces es la Manchester Diferencial
                ManchesterDiferencial( app, bits ); % Ejecutamos la modulaci�n de Manchester Diferencial
            end
        end % Fin de la funci�n para el bot�n Graficar

        % Button pushed function: BtnBorrar
        function BtnBorrarButtonPushed(app, event)
            app.TrendebitsEditField.Value = ' '; % Limpiamos el campo de tren de bits
            app.GraficaM.clo; % Limpiamos la grafica de Manchester 
            axis( app.GraficaM, [ 0 1 0 1 ] ); % Asignamos los ejes a la grafica de M
            app.GraficaMD.clo; % Limpiamos la grafica de Manchester Diferencial
            axis( app.GraficaMD, [ 0 1 0 1 ]); % Asignamos los ejes a la grafica de MD
        end % Fin de la funci�n para el bot�n de Borrar
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
            app.BtnGraficar.Position = [740 643 69 23];
            app.BtnGraficar.Text = 'Graficar';

            % Create GarcaGarcaJosngelLabel
            app.GarcaGarcaJosngelLabel = uilabel(app.UIFigure);
            app.GarcaGarcaJosngelLabel.FontSize = 14;
            app.GarcaGarcaJosngelLabel.FontWeight = 'bold';
            app.GarcaGarcaJosngelLabel.FontAngle = 'italic';
            app.GarcaGarcaJosngelLabel.Position = [632 1 175 22];
            app.GarcaGarcaJosngelLabel.Text = 'Garc�a Garc�a Jos� �ngel';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontName = 'Consolas';
            app.Label.FontSize = 14;
            app.Label.FontWeight = 'bold';
            app.Label.FontAngle = 'italic';
            app.Label.Position = [1 673 842 24];
            app.Label.Text = 'Fundamentos de Telecomunicaciones - Graficador de Submodulaci�n de Polar Manchester y Manchester Diferencial';

            % Create BtnBorrar
            app.BtnBorrar = uibutton(app.UIFigure, 'push');
            app.BtnBorrar.ButtonPushedFcn = createCallbackFcn(app, @BtnBorrarButtonPushed, true);
            app.BtnBorrar.BackgroundColor = [0.898 0.9294 0.298];
            app.BtnBorrar.FontName = 'Consolas';
            app.BtnBorrar.FontWeight = 'bold';
            app.BtnBorrar.Position = [740 610 67 23];
            app.BtnBorrar.Text = 'Borrar';

            % Create TrendebitsLabel
            app.TrendebitsLabel = uilabel(app.UIFigure);
            app.TrendebitsLabel.HorizontalAlignment = 'right';
            app.TrendebitsLabel.FontName = 'Consolas';
            app.TrendebitsLabel.FontSize = 14;
            app.TrendebitsLabel.FontWeight = 'bold';
            app.TrendebitsLabel.Position = [37 643 105 23];
            app.TrendebitsLabel.Text = 'Tren de bits:';

            % Create TrendebitsEditField
            app.TrendebitsEditField = uieditfield(app.UIFigure, 'text');
            app.TrendebitsEditField.HorizontalAlignment = 'center';
            app.TrendebitsEditField.FontName = 'Consolas';
            app.TrendebitsEditField.FontSize = 14;
            app.TrendebitsEditField.FontWeight = 'bold';
            app.TrendebitsEditField.Position = [157 644 352 22];

            % Create ModulacinDropDownLabel
            app.ModulacinDropDownLabel = uilabel(app.UIFigure);
            app.ModulacinDropDownLabel.HorizontalAlignment = 'right';
            app.ModulacinDropDownLabel.FontName = 'Consolas';
            app.ModulacinDropDownLabel.FontSize = 14;
            app.ModulacinDropDownLabel.FontWeight = 'bold';
            app.ModulacinDropDownLabel.Position = [52 610 90 22];
            app.ModulacinDropDownLabel.Text = 'Modulaci�n:';

            % Create SelMod
            app.SelMod = uidropdown(app.UIFigure);
            app.SelMod.Items = {'Manchester', 'Manchester Diferencial', 'Ambas'};
            app.SelMod.FontSize = 14;
            app.SelMod.Position = [157 610 181 22];
            app.SelMod.Value = 'Manchester';

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