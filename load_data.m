DATA_DIR = "C:\Users\George Sykes\OneDrive - University of Leeds\Documents\year 4\project\group work\Previous data analysis\Previous Data from Leeds\bovine disc tests\*\Extract cyclic data";

data = load_all_data(DATA_DIR);

function data = load_all_data(data_dir)
    files = dir(data_dir + "\*group*.csv");
    
    data = cell2table(cell(0,16), 'VariableNames', {'TotalTime_hrs_', 'TotalCycles', 'Step', 'Position_Linear_10_0_0_2_0__Position__mm_', 'Load_Linear_10_0_0_2_0__Load__N_', 'Displacement_Linear_10_0_0_2_0__DigitalPosition__mm_', 'SpecimenHeight_mm_', 'DerivedDiscHeight_mm_', 'DeltaH_mm_', 'DiscStress_MPa_', 'DiscStrain', 'state', 'tail' ,'disc_id', 'disc_index', 'group_id'});
    
    for file_index = 1:length(files)
        disc_data = load_file(files(file_index));
        data = [data; disc_data]; 
    end
end

function disc_data = load_file(file)
        disc_info = process_filename(file.name);
        disc_data = readtable(strcat(file.folder + "\" + file.name));
        disc_data.("tail") = repmat(disc_info(1), size(disc_data,1), 1);
        disc_data.("state") = repmat(disc_info(2), size(disc_data,1), 1);
        disc_data.("disc_id") = repmat(disc_info(3), size(disc_data,1), 1);
        disc_data.("disc_index") = repmat(disc_info(4), size(disc_data,1), 1);
        disc_data.("group_id") = repmat(disc_info(5), size(disc_data,1), 1);
end

function disc_info = process_filename(filename)
    disc_info = {};
    data = split(filename, ["-", "_", "."]);
    disc_info(1) = cellstr(data{1});
    disc_info(2) = cellstr(get_state_from_name_part(data));
    disc_info(3) = cellstr(get_disc_id_from_name(data));
    disc_info(4) = cellstr(get_disc_index_from_name(data));
    disc_info(5) = cellstr(get_group_from_name(data));
    return
end

function state = get_state_from_name_part(name)
    state = name{2}(end);
    return
end

function disc_id = get_disc_id_from_name(name)
    disc_id = strcat(name{1}, name{2}(1:2));
    return
end

function disc_index = get_disc_index_from_name(name)
    disc_index = name{2}(2);
    return
end

function disc_name = get_group_from_name(name)
    disc_name = name{3}(end);
end