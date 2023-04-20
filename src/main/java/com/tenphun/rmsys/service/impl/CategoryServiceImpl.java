package com.tenphun.rmsys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tenphun.rmsys.common.BusinessException;
import com.tenphun.rmsys.entity.Category;
import com.tenphun.rmsys.entity.Dish;
import com.tenphun.rmsys.entity.Setmeal;
import com.tenphun.rmsys.mapper.CategoryMapper;
import com.tenphun.rmsys.service.CategoryService;
import com.tenphun.rmsys.service.DishService;
import com.tenphun.rmsys.service.SetmealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {
    /**
     * Delete but check if there are connection with Dish and Setmeal first
     */

    @Autowired
    private DishService dishService;
    @Autowired
    private SetmealService setmealService;
    @Override
    public void remove(Long id) {
        // check Dish table
        LambdaQueryWrapper<Dish> dishWrapper= new LambdaQueryWrapper<>();
        dishWrapper.eq(Dish::getCategoryId, id);
        long count = dishService.count(dishWrapper);
        if(count>0) throw new BusinessException("The category cannot be deleted, dishes are associated with the category");

        // check Setmeal Table
        LambdaQueryWrapper<Setmeal> setmealWrapper = new LambdaQueryWrapper<>();
        setmealWrapper.eq(Setmeal::getCategoryId, id);
        count = setmealService.count(setmealWrapper);
        if(count>0) throw new BusinessException("The category cannot be deleted, set meals are associated with the category");

        super.removeById(id);
    }
}
