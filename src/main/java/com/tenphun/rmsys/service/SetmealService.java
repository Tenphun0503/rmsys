package com.tenphun.rmsys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tenphun.rmsys.dto.DishDto;
import com.tenphun.rmsys.dto.SetmealDto;
import com.tenphun.rmsys.entity.Setmeal;
import com.tenphun.rmsys.entity.SetmealDish;

public interface SetmealService extends IService<Setmeal> {
    void addWithDishes(SetmealDto setmealDto);
    SetmealDto getByIdWithDishes(Long id);
    void updateWithDishes(SetmealDto dto);
    void deleteWithDishes(Long[] ids);
    void updateStatus(Long[] ids, Integer status);
}
