package com.tenphun.rmsys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tenphun.rmsys.dto.DishDto;
import com.tenphun.rmsys.dto.SetmealDto;
import com.tenphun.rmsys.entity.Setmeal;
import com.tenphun.rmsys.entity.SetmealDish;

import java.util.List;

public interface SetmealService extends IService<Setmeal> {
    void addWithDishes(SetmealDto setmealDto);
    SetmealDto getByIdWithDishes(Long id);
    void updateWithDishes(SetmealDto dto);
    void deleteWithDishes(List<Long> ids);
    void updateStatus(List<Long> ids, Integer status);
}
