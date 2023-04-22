package com.tenphun.rmsys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tenphun.rmsys.dto.DishDto;
import com.tenphun.rmsys.entity.Dish;

import java.util.List;


public interface DishService extends IService<Dish> {
    void saveWithFlavor(DishDto dishDto);
    DishDto getByIdWithFlavor(Long id);
    void updateWithFlavor(DishDto dishDto);
    void deleteWithFlavor(List<Long> ids);
    void updateStatus(List<Long> ids, Integer status);
}
