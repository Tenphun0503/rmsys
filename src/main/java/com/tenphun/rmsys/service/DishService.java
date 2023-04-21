package com.tenphun.rmsys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tenphun.rmsys.dto.DishDto;
import com.tenphun.rmsys.entity.Dish;


public interface DishService extends IService<Dish> {
    void saveWithFlavor(DishDto dishDto);
}
