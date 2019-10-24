function varargout = OptimatorV2(varargin)
% OPTIMATORV2 MATLAB code for OptimatorV2.fig
%      OPTIMATORV2, by itself, creates a new OPTIMATORV2 or raises the existing
%      singleton*.
%
%      H = OPTIMATORV2 returns the handle to a new OPTIMATORV2 or the handle to
%      the existing singleton*.
%
%      OPTIMATORV2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTIMATORV2.M with the given input arguments.
%
%      OPTIMATORV2('Property','Value',...) creates a new OPTIMATORV2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OptimatorV2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OptimatorV2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OptimatorV2

% Last Modified by GUIDE v2.5 01-Nov-2017 06:01:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OptimatorV2_OpeningFcn, ...
                   'gui_OutputFcn',  @OptimatorV2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before OptimatorV2 is made visible.
function OptimatorV2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OptimatorV2 (see VARARGIN)

% Choose default command line output for OptimatorV2
handles.output = hObject;
%set(handles.datedate,'String',date);

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'onscreen')    % Menampilkan program di layar
movegui(hObject,'center')
[imIP,map,alpha]=imread ('ip.png');
[imUGM,map,beta]=imread ('ugm.png');
axes(handles.logoIP);
handles.IP = imshow(imIP);
set(handles.IP,'AlphaData',alpha);
axes(handles.logoUGM);
handles.UGM = imshow(imUGM);
set(handles.UGM,'AlphaData',beta);  
clc;
set(get(handles.grafik,'xlabel'), 'string', 'Waktu (Jam)')
set(get(handles.grafik,'ylabel'), 'string', 'Beban (MW)')
set(get(handles.grafik,'title'), 'string', 'Grafik Pembebanan pada Pembangkit terhadap Waktu')

global beban_min1 beban_max1 beban_unit1
global beban_min2 beban_max2 beban_unit2
global beban_min3 beban_max3 beban_unit3
global beban_request

beban_min1 = 200;
beban_min2 = 200;
beban_min3 = 200;
beban_max1 = 315;
beban_max2 = 315;
beban_max3 = 315;
beban_unit1 = 0;
beban_unit2 = 0;
beban_unit3 = 0;
beban_request = 0;

excel = xlsread('D:\Kuliah\Semester 7\Kerja Praktik 2017\Milestone\Optimasi Pembebanan\Optimator 2nd\DATA ROH FIKRI','Sheet2','B2:D96');   

global tanggal bulan tahun
tanggal = excel(1,1);
bulan = excel(1,2);
tahun = excel(1,3);

[month] = findmonth(bulan);
set(handles.todo,'String',[num2str(tanggal),'-',[month],'-',num2str(tahun)])

% UIWAIT makes OptimatorV2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = OptimatorV2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Outputs from this function are returned to the command line.
function varargout = OptimatorV2_OutputFcn(~, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in hitung.
function hitung_Callback(hObject, eventdata, handles)
% hObject    handle to hitung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global beban_min1 beban_max1 
global beban_min2 beban_max2 
global beban_min3 beban_max3 
global tanggal bulan tahun

unit1_a = 15.59;
unit1_b = 443872.57;
unit1_c = 8854230.19;
unit1_d = beban_min1;
unit1_e = beban_max1;
data1 = [unit1_a,unit1_b,unit1_c,unit1_d,unit1_e];

unit2_a = 432.52;
unit2_b = 228835.28;
unit2_c = 26186478.79;
unit2_d = beban_min2;
unit2_e = beban_max2;
data2 = [unit2_a,unit2_b,unit2_c,unit2_d,unit2_e];

unit3_a = 928.68;
unit3_b = -130876.67;
unit3_c = 81788363.85;
unit3_d = beban_min3;
unit3_e = beban_max3;
data3 = [unit3_a,unit3_b,unit3_c,unit3_d,unit3_e];

data = [data1;data2;data3];

data_excel = xlsread('D:\Kuliah\Semester 7\Kerja Praktik 2017\Milestone\Optimasi Pembebanan\Optimator 3rd\DATA ROH FIKRI','Sheet2','A2:H49');   

[pagi_nettROH] = avg_nettROH(data_excel, 1, tanggal, bulan, tahun);
[siang_nettROH] = avg_nettROH(data_excel, 2, tanggal, bulan, tahun);
[malam_nettROH] = avg_nettROH(data_excel, 3, tanggal, bulan, tahun);
[detail_nettROH] = data_excel(:,7);

Pd1 = pagi_nettROH;
Pd1_siang = siang_nettROH;
Pd1_malam = malam_nettROH;
Pd1_detail = detail_nettROH;

beban_pagi = Pd1;
beban_siang = Pd1_siang;
beban_malam = Pd1_malam;
beban_detail = Pd1_detail;
beban = (beban_pagi + beban_siang + beban_malam)/3;

program_ED;

unit1_pagi = round(PP_pagi(1));
unit2_pagi = round(PP_pagi(2));
unit3_pagi = round(PP_pagi(3));
unit1_siang = round(PP_siang(1));
unit2_siang = round(PP_siang(2));
unit3_siang = round(PP_siang(3));
unit1_malam = round(PP_malam(1));
unit2_malam = round(PP_malam(2));
unit3_malam = round(PP_malam(3));
unit1_detail = round(PP_detail(:,1));
unit2_detail = round(PP_detail(:,2));
unit3_detail = round(PP_detail(:,3));

beban_optimal_pagi = unit1_pagi + unit2_pagi + unit3_pagi;
beban_optimal_siang = unit1_siang + unit2_siang + unit3_siang;
beban_optimal_malam = unit1_malam + unit2_malam + unit3_malam;

total_min = beban_min1 + beban_min2 + beban_min3 ;
total_max = beban_max1 + beban_max2 + beban_max3 ;

if ((beban_optimal_pagi<total_min) & (beban_optimal_siang<total_min) & (beban_optimal_malam<total_min))
    warndlg('Beban yang diminta lebih rendah dari Technical Minimum Load Unit','!! Warning !!')
elseif ((beban_optimal_pagi>total_max) & (beban_optimal_siang>total_max) & (beban_optimal_malam>total_max))
    warndlg('Beban yang diminta melebihi beban maksimum unit','!! Warning !!')
else
    
nphr1_pagi = Tcost1_pagi/(unit1_pagi*1000*0.1687234);
nphr2_pagi = Tcost2_pagi/(unit2_pagi*1000*0.1687234);
nphr3_pagi = Tcost3_pagi/(unit3_pagi*1000*0.1687234);
nphr1_siang = Tcost1_siang/(unit1_siang*1000*0.1687234);
nphr2_siang = Tcost2_siang/(unit2_siang*1000*0.1687234);
nphr3_siang = Tcost3_siang/(unit3_siang*1000*0.1687234);
nphr1_malam = Tcost1_malam/(unit1_malam*1000*0.1687234);
nphr2_malam = Tcost2_malam/(unit2_malam*1000*0.1687234);
nphr3_malam = Tcost3_malam/(unit3_malam*1000*0.1687234);

biaya_pembangkitan = sprintf('%10.2f',Tcost);
average_nphr = Tcost/((beban)*1000*0.1687234);
biaya_produksi = Tcost/(beban*1000);

kalori_unit1_a = 0.457;
kalori_unit1_b = 0.806;
kalori_unit1_const = 2443.743;
kalori_unit2_a = 1.351;
kalori_unit2_b = 0.695;
kalori_unit2_const = 2486.969;
kalori_unit3_a = 0.645;
kalori_unit3_b = 0.414;
kalori_unit3_const = 3370.328;

jenis_kalori_unit1_pagi = kalori_unit1_a*unit1_pagi + kalori_unit1_b*nphr1_pagi + kalori_unit1_const;
jenis_kalori_unit2_pagi = kalori_unit2_a*unit2_pagi + kalori_unit2_b*nphr2_pagi + kalori_unit2_const;
jenis_kalori_unit3_pagi = kalori_unit3_a*unit3_pagi + kalori_unit3_b*nphr3_pagi + kalori_unit3_const;
jenis_kalori_unit1_siang = kalori_unit1_a*unit1_siang + kalori_unit1_b*nphr1_siang + kalori_unit1_const;
jenis_kalori_unit2_siang = kalori_unit2_a*unit2_siang + kalori_unit2_b*nphr2_siang + kalori_unit2_const;
jenis_kalori_unit3_siang = kalori_unit3_a*unit3_siang + kalori_unit3_b*nphr3_siang + kalori_unit3_const;
jenis_kalori_unit1_malam = kalori_unit1_a*unit1_malam + kalori_unit1_b*nphr1_malam + kalori_unit1_const;
jenis_kalori_unit2_malam = kalori_unit2_a*unit2_malam + kalori_unit2_b*nphr2_malam + kalori_unit2_const;
jenis_kalori_unit3_malam = kalori_unit3_a*unit3_malam + kalori_unit3_b*nphr3_malam + kalori_unit3_const;

average_jenis_kalori_pagi = (jenis_kalori_unit1_pagi + jenis_kalori_unit2_pagi + jenis_kalori_unit3_pagi)/3;
average_jenis_kalori_siang = (jenis_kalori_unit1_siang + jenis_kalori_unit2_siang + jenis_kalori_unit3_siang)/3;
average_jenis_kalori_malam = (jenis_kalori_unit1_malam + jenis_kalori_unit2_malam + jenis_kalori_unit3_malam)/3;

total_kalori_unit1_pagi = (unit1_pagi*nphr1_pagi)/average_jenis_kalori_pagi;
total_kalori_unit2_pagi = (unit2_pagi*nphr2_pagi)/average_jenis_kalori_pagi;
total_kalori_unit3_pagi = (unit3_pagi*nphr3_pagi)/average_jenis_kalori_pagi;
total_kalori_unit1_siang = (unit1_siang*nphr1_siang)/average_jenis_kalori_siang;
total_kalori_unit2_siang = (unit2_siang*nphr2_siang)/average_jenis_kalori_siang;
total_kalori_unit3_siang = (unit3_siang*nphr3_siang)/average_jenis_kalori_siang;
total_kalori_unit1_malam = (unit1_malam*nphr1_malam)/average_jenis_kalori_malam;
total_kalori_unit2_malam = (unit2_malam*nphr2_malam)/average_jenis_kalori_malam;
total_kalori_unit3_malam = (unit3_malam*nphr3_malam)/average_jenis_kalori_malam;

%average_total_kalori = (total_kalori_unit1 + total_kalori_unit2 + total_kalori_unit3)/3;

set(handles.optimal_1_pagi, 'String', unit1_pagi);
set(handles.optimal_2_pagi, 'String', unit2_pagi);
set(handles.optimal_3_pagi, 'String', unit3_pagi);
set(handles.optimal_1_siang, 'String', unit1_siang);
set(handles.optimal_2_siang, 'String', unit2_siang);
set(handles.optimal_3_siang, 'String', unit3_siang);
set(handles.optimal_1_malam, 'String', unit1_malam);
set(handles.optimal_2_malam, 'String', unit2_malam);
set(handles.optimal_3_malam, 'String', unit3_malam);

set(handles.nphr_1_pagi, 'String', nphr1_pagi);
set(handles.nphr_2_pagi, 'String', nphr2_pagi);
set(handles.nphr_3_pagi, 'String', nphr3_pagi);
set(handles.nphr_1_siang, 'String', nphr1_siang);
set(handles.nphr_2_siang, 'String', nphr2_siang);
set(handles.nphr_3_siang, 'String', nphr3_siang);
set(handles.nphr_1_malam, 'String', nphr1_malam);
set(handles.nphr_2_malam, 'String', nphr2_malam);
set(handles.nphr_3_malam, 'String', nphr3_malam);

set(handles.total_kalori_unit1_pagi, 'String', total_kalori_unit1_pagi);
set(handles.total_kalori_unit2_pagi, 'String', total_kalori_unit2_pagi);
set(handles.total_kalori_unit3_pagi, 'String', total_kalori_unit3_pagi);
set(handles.total_kalori_unit1_siang, 'String', total_kalori_unit1_siang);
set(handles.total_kalori_unit2_siang, 'String', total_kalori_unit2_siang);
set(handles.total_kalori_unit3_siang, 'String', total_kalori_unit3_siang);
set(handles.total_kalori_unit1_malam, 'String', total_kalori_unit1_malam);
set(handles.total_kalori_unit2_malam, 'String', total_kalori_unit2_malam);
set(handles.total_kalori_unit3_malam, 'String', total_kalori_unit3_malam);

set(handles.average_nphr, 'String', average_nphr);
set(handles.biaya_pembangkitan, 'String', biaya_pembangkitan);
set(handles.biaya_produksi, 'String',biaya_produksi);
%set(handles.average_total_kalori, 'String', average_total_kalori);

set(handles.average_jenis_kalori_pagi, 'String', average_jenis_kalori_pagi);
set(handles.average_jenis_kalori_siang, 'String', average_jenis_kalori_siang);
set(handles.average_jenis_kalori_malam, 'String', average_jenis_kalori_malam);

[month_status] = findmonth(bulan);
set(handles.status_shift_pagi,'String',[num2str(01),':',num2str(30),' - ',num2str(08),':',num2str(30),'  ',num2str(tanggal), '-',num2str(month_status), '-',num2str(tahun),' - ',num2str(beban_optimal_pagi),' MW'])
set(handles.status_shift_siang,'String',[num2str(08),':',num2str(30),' - ',num2str(16),':',num2str(00),'  ',num2str(tanggal), '-',num2str(month_status), '-',num2str(tahun),' - ',num2str(beban_optimal_siang),' MW'])
set(handles.status_shift_malam,'String',[num2str(16),':',num2str(30),' - ',num2str(23),':',num2str(59),'  ',num2str(tanggal), '-',num2str(month_status), '-',num2str(tahun),' - ',num2str(beban_optimal_malam),' MW'])


x_time = data_excel(: ,8);
y_load = data_excel(: ,7);
y_load_unit1 = unit1_detail;
y_load_unit2 = unit2_detail;
y_load_unit3 = unit3_detail;

axes(handles.grafik);
cla;
index = get(handles.menu_beban,'Value')
switch index
    case 1
        plot(x_time,y_load);
    case 2
        plot(x_time,y_load_unit1);
    case 3
        plot(x_time,y_load_unit2);
    case 4
        plot(x_time,y_load_unit3);
end
  
xlim([0 25])
ylim([0 1000])

grid on
set(get(handles.grafik,'xlabel'), 'string', 'Waktu (Jam)')
set(get(handles.grafik,'ylabel'), 'string', 'Beban (MW)')
set(get(handles.grafik,'title'), 'string', 'Grafik Pembebanan pada Pembangkit terhadap Waktu')

end

function [avg_nettROH] = avg_nettROH(data_excel, shift, date, month, year)
    if(shift == 1 & data_excel(1,2) == date & data_excel(1,5) == 0 & data_excel(1,6) == 30)
        shift_nettROH = data_excel(1:16,7);
    elseif(shift == 2 & data_excel(17,2) == date & data_excel(17,5) == 8 & data_excel(17,6) == 30)
        shift_nettROH = data_excel(17:32,7);
    elseif(shift == 3  & data_excel(33,2) == date & data_excel(33,5) == 16 & data_excel(33,6) == 30)
        shift_nettROH = data_excel(33:48,7);
    end
    avg = sum(shift_nettROH)/16;
    avg_nettROH = avg;
 
function [month]=findmonth(number)
switch number
    case 1;m='Jan';case 2;m='Feb';case 3;m='March';case 4;m='Apr';case 5;m='May';case 6;m='June';
    case 7;m='July';case 8;m='Aug';case 9;m='Sept';case 10;m='Oct';case 11;m='Nov';case 12;m='Dec';
end;month = m;


% --- Executes during object creation, after setting all properties.
function tahun_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tahun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function optimal_1_pagi_Callback(hObject, eventdata, handles)
% hObject    handle to optimal_1_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of optimal_1_pagi as text
%        str2double(get(hObject,'String')) returns contents of optimal_1_pagi as a double


% --- Executes during object creation, after setting all properties.
function optimal_1_pagi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optimal_1_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function optimal_2_pagi_Callback(hObject, eventdata, handles)
% hObject    handle to optimal_2_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of optimal_2_pagi as text
%        str2double(get(hObject,'String')) returns contents of optimal_2_pagi as a double


% --- Executes during object creation, after setting all properties.
function optimal_2_pagi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optimal_2_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function optimal_3_pagi_Callback(hObject, eventdata, handles)
% hObject    handle to optimal_3_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of optimal_3_pagi as text
%        str2double(get(hObject,'String')) returns contents of optimal_3_pagi as a double


% --- Executes during object creation, after setting all properties.
function optimal_3_pagi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optimal_3_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function nphr_1_pagi_Callback(hObject, eventdata, handles)
% hObject    handle to nphr_1_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nphr_1_pagi as text
%        str2double(get(hObject,'String')) returns contents of nphr_1_pagi as a double


% --- Executes during object creation, after setting all properties.
function nphr_1_pagi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nphr_1_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nphr_2_pagi_Callback(hObject, eventdata, handles)
% hObject    handle to nphr_2_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nphr_2_pagi as text
%        str2double(get(hObject,'String')) returns contents of nphr_2_pagi as a double


% --- Executes during object creation, after setting all properties.
function nphr_2_pagi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nphr_2_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nphr_3_pagi_Callback(hObject, eventdata, handles)
% hObject    handle to nphr_3_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nphr_3_pagi as text
%        str2double(get(hObject,'String')) returns contents of nphr_3_pagi as a double


% --- Executes during object creation, after setting all properties.
function nphr_3_pagi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nphr_3_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_kalori_unit1_pagi_Callback(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit1_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_kalori_unit1_pagi as text
%        str2double(get(hObject,'String')) returns contents of total_kalori_unit1_pagi as a double


% --- Executes during object creation, after setting all properties.
function total_kalori_unit1_pagi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit1_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_kalori_unit2_pagi_Callback(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit2_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_kalori_unit2_pagi as text
%        str2double(get(hObject,'String')) returns contents of total_kalori_unit2_pagi as a double


% --- Executes during object creation, after setting all properties.
function total_kalori_unit2_pagi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit2_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_kalori_unit3_pagi_Callback(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit3_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_kalori_unit3_pagi as text
%        str2double(get(hObject,'String')) returns contents of total_kalori_unit3_pagi as a double


% --- Executes during object creation, after setting all properties.
function total_kalori_unit3_pagi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit3_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function optimal_1_siang_Callback(hObject, eventdata, handles)
% hObject    handle to optimal_1_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of optimal_1_siang as text
%        str2double(get(hObject,'String')) returns contents of optimal_1_siang as a double


% --- Executes during object creation, after setting all properties.
function optimal_1_siang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optimal_1_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function optimal_2_siang_Callback(hObject, eventdata, handles)
% hObject    handle to optimal_2_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of optimal_2_siang as text
%        str2double(get(hObject,'String')) returns contents of optimal_2_siang as a double


% --- Executes during object creation, after setting all properties.
function optimal_2_siang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optimal_2_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function optimal_3_siang_Callback(hObject, eventdata, handles)
% hObject    handle to optimal_3_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of optimal_3_siang as text
%        str2double(get(hObject,'String')) returns contents of optimal_3_siang as a double


% --- Executes during object creation, after setting all properties.
function optimal_3_siang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optimal_3_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nphr_1_siang_Callback(hObject, eventdata, handles)
% hObject    handle to nphr_1_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nphr_1_siang as text
%        str2double(get(hObject,'String')) returns contents of nphr_1_siang as a double


% --- Executes during object creation, after setting all properties.
function nphr_1_siang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nphr_1_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nphr_2_siang_Callback(hObject, eventdata, handles)
% hObject    handle to nphr_2_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nphr_2_siang as text
%        str2double(get(hObject,'String')) returns contents of nphr_2_siang as a double


% --- Executes during object creation, after setting all properties.
function nphr_2_siang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nphr_2_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nphr_3_siang_Callback(hObject, eventdata, handles)
% hObject    handle to nphr_3_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nphr_3_siang as text
%        str2double(get(hObject,'String')) returns contents of nphr_3_siang as a double


% --- Executes during object creation, after setting all properties.
function nphr_3_siang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nphr_3_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_kalori_unit1_siang_Callback(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit1_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_kalori_unit1_siang as text
%        str2double(get(hObject,'String')) returns contents of total_kalori_unit1_siang as a double


% --- Executes during object creation, after setting all properties.
function total_kalori_unit1_siang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit1_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_kalori_unit2_siang_Callback(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit2_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_kalori_unit2_siang as text
%        str2double(get(hObject,'String')) returns contents of total_kalori_unit2_siang as a double


% --- Executes during object creation, after setting all properties.
function total_kalori_unit2_siang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit2_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_kalori_unit3_siang_Callback(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit3_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_kalori_unit3_siang as text
%        str2double(get(hObject,'String')) returns contents of total_kalori_unit3_siang as a double


% --- Executes during object creation, after setting all properties.
function total_kalori_unit3_siang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit3_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function optimal_1_malam_Callback(hObject, eventdata, handles)
% hObject    handle to optimal_1_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of optimal_1_malam as text
%        str2double(get(hObject,'String')) returns contents of optimal_1_malam as a double


% --- Executes during object creation, after setting all properties.
function optimal_1_malam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optimal_1_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function optimal_2_malam_Callback(hObject, eventdata, handles)
% hObject    handle to optimal_2_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of optimal_2_malam as text
%        str2double(get(hObject,'String')) returns contents of optimal_2_malam as a double


% --- Executes during object creation, after setting all properties.
function optimal_2_malam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optimal_2_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function optimal_3_malam_Callback(hObject, eventdata, handles)
% hObject    handle to optimal_3_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of optimal_3_malam as text
%        str2double(get(hObject,'String')) returns contents of optimal_3_malam as a double


% --- Executes during object creation, after setting all properties.
function optimal_3_malam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optimal_3_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nphr_1_malam_Callback(hObject, eventdata, handles)
% hObject    handle to nphr_1_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nphr_1_malam as text
%        str2double(get(hObject,'String')) returns contents of nphr_1_malam as a double


% --- Executes during object creation, after setting all properties.
function nphr_1_malam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nphr_1_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nphr_2_malam_Callback(hObject, eventdata, handles)
% hObject    handle to nphr_2_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nphr_2_malam as text
%        str2double(get(hObject,'String')) returns contents of nphr_2_malam as a double


% --- Executes during object creation, after setting all properties.
function nphr_2_malam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nphr_2_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nphr_3_malam_Callback(hObject, eventdata, handles)
% hObject    handle to nphr_3_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nphr_3_malam as text
%        str2double(get(hObject,'String')) returns contents of nphr_3_malam as a double


% --- Executes during object creation, after setting all properties.
function nphr_3_malam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nphr_3_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_kalori_unit1_malam_Callback(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit1_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_kalori_unit1_malam as text
%        str2double(get(hObject,'String')) returns contents of total_kalori_unit1_malam as a double


% --- Executes during object creation, after setting all properties.
function total_kalori_unit1_malam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit1_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_kalori_unit2_malam_Callback(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit2_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_kalori_unit2_malam as text
%        str2double(get(hObject,'String')) returns contents of total_kalori_unit2_malam as a double


% --- Executes during object creation, after setting all properties.
function total_kalori_unit2_malam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit2_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_kalori_unit3_malam_Callback(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit3_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_kalori_unit3_malam as text
%        str2double(get(hObject,'String')) returns contents of total_kalori_unit3_malam as a double


% --- Executes during object creation, after setting all properties.
function total_kalori_unit3_malam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_kalori_unit3_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function average_nphr_Callback(hObject, eventdata, handles)
% hObject    handle to average_nphr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of average_nphr as text
%        str2double(get(hObject,'String')) returns contents of average_nphr as a double


% --- Executes during object creation, after setting all properties.
function average_nphr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to average_nphr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function biaya_pembangkitan_Callback(hObject, eventdata, handles)
% hObject    handle to biaya_pembangkitan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of biaya_pembangkitan as text
%        str2double(get(hObject,'String')) returns contents of biaya_pembangkitan as a double


% --- Executes during object creation, after setting all properties.
function biaya_pembangkitan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to biaya_pembangkitan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function biaya_produksi_Callback(hObject, eventdata, handles)
% hObject    handle to biaya_produksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of biaya_produksi as text
%        str2double(get(hObject,'String')) returns contents of biaya_produksi as a double


% --- Executes during object creation, after setting all properties.
function biaya_produksi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to biaya_produksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function average_jenis_kalori_pagi_Callback(hObject, eventdata, handles)
% hObject    handle to average_jenis_kalori_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of average_jenis_kalori_pagi as text
%        str2double(get(hObject,'String')) returns contents of average_jenis_kalori_pagi as a double

% --- Executes during object creation, after setting all properties.
function average_jenis_kalori_pagi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to average_jenis_kalori_pagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function average_jenis_kalori_siang_Callback(hObject, eventdata, handles)
% hObject    handle to average_jenis_kalori_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of average_jenis_kalori_siang as text
%        str2double(get(hObject,'String')) returns contents of average_jenis_kalori_siang as a double

% --- Executes during object creation, after setting all properties.
function average_jenis_kalori_siang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to average_jenis_kalori_siang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function average_jenis_kalori_malam_Callback(hObject, eventdata, handles)
% hObject    handle to average_jenis_kalori_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of average_jenis_kalori_malam as text
%        str2double(get(hObject,'String')) returns contents of average_jenis_kalori_malam as a double


% --- Executes during object creation, after setting all properties.
function average_jenis_kalori_malam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to average_jenis_kalori_malam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in menu_beban.
function menu_beban_Callback(hObject, eventdata, handles)
% hObject    handle to menu_beban (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu_beban contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu_beban

% --- Executes during object creation, after setting all properties.
function menu_beban_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu_beban (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'Beban 3 Unit', 'Beban Unit 1', 'Beban Unit 2', 'Beban Unit 3'});
