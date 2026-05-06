USE RikkeiClinicDB;

delimiter //

create procedure sp_tinh_chi_phi_xuat_vien(
    in p_tong_chi_phi decimal(18,2),
    in p_dien_benh_nhan varchar(20),
    out p_so_tien_phu_thu decimal(18,2),
    out p_thong_bao varchar(100)
)
begin
    if p_tong_chi_phi < 0 then
        set p_so_tien_phu_thu = 0;
        set p_thong_bao = 'lỗi: chi phí không hợp lệ';
    
    else
        case p_dien_benh_nhan
            when 'bhyt' then
                set p_so_tien_phu_thu = p_tong_chi_phi * 0.2;
                set p_thong_bao = 'đã tính toán xong';
            
            when 'vip' then
                set p_so_tien_phu_thu = p_tong_chi_phi * 0.9;
                set p_thong_bao = 'đã tính toán xong';
            
            when 'thuong' then
                -- thu 100%
                set p_so_tien_phu_thu = p_tong_chi_phi;
                set p_thong_bao = 'đã tính toán xong';
            
            else
                set p_so_tien_phu_thu = p_tong_chi_phi;
                set p_thong_bao = 'diện bệnh nhân không xác định';
        end case;
    end if;
end //

delimiter ;


call sp_tinh_chi_phi_xuat_vien(1000000, 'bhyt', @result, @msg);
select @result, @msg;

call sp_tinh_chi_phi_xuat_vien(1000000, 'vip', @result, @msg);


call sp_tinh_chi_phi_xuat_vien(1000000, 'thuong', @result, @msg);


call sp_tinh_chi_phi_xuat_vien(-500000, 'bhyt', @result, @msg);
