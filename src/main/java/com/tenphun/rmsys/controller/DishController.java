package com.tenphun.rmsys.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tenphun.rmsys.common.R;
import com.tenphun.rmsys.dto.DishDto;
import com.tenphun.rmsys.entity.Dish;
import com.tenphun.rmsys.service.CategoryService;
import com.tenphun.rmsys.service.DishFlavorService;
import com.tenphun.rmsys.service.DishService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/dish")
public class DishController {

    @Autowired
    DishService dishService;
    @Autowired
    DishFlavorService dishFlavorService;
    @Autowired
    CategoryService categoryService;

    /**
     * Add a dish
     */
    @PostMapping
    public R<String> add(@RequestBody DishDto dishDto){
        dishService.saveWithFlavor(dishDto);
        return R.success("Add 1");
    }

    /**
     * Show dishes through pagination
     */
    @GetMapping("/page")
    public R<Page<DishDto>> getByPage(int page, int pageSize, String name){
        // Pagination object
        Page<Dish> dishPage = new Page<>(page, pageSize);
        // Set Condition and get data
        LambdaQueryWrapper<Dish> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotEmpty(name), Dish::getName, name);
        wrapper.orderByDesc(Dish::getUpdateTime);
        dishService.page(dishPage, wrapper);
        // Set Dto pagination
        Page<DishDto> dishDtoPage = new Page<>(page, pageSize);
        // Copy others from dishPage
        BeanUtils.copyProperties(dishPage, dishDtoPage, "records");
        // modify records and save them
        List<Dish> dishList = dishPage.getRecords();
        List<DishDto> dtoList = new ArrayList<>();

        dishList.forEach(dish->{
            DishDto dishDto = new DishDto();
            BeanUtils.copyProperties(dish, dishDto);
            dishDto.setCategoryName(categoryService.getById(dish.getCategoryId()).getName());
            dtoList.add(dishDto);
        });
        dishDtoPage.setRecords(dtoList);

        return R.success(dishDtoPage);
    }

    /**
     * Get by id
     */
    @GetMapping("/{id}")
    public R<DishDto> getById(@PathVariable Long id){
        DishDto dto = dishService.getByIdWithFlavor(id);
        return R.success(dto);
    }

    /**
     * Update Dish
     */
    @PutMapping
    public R<String> update(@RequestBody DishDto dto){
        dishService.updateWithFlavor(dto);
        return R.success("update 1");
    }

    /**
     * delete dish
     */
    @DeleteMapping
    public R<String> delete(Long[] ids){
        dishService.deleteWithFlavor(ids);
        return R.success("delete 1");
    }

    @PostMapping("/status/{status}")
    public R<String> updateStatus(Long[] ids, @PathVariable Integer status){
        dishService.updateStatus(ids, status);
        return R.success("onSale 1");
    }

    @GetMapping("/list")
    public R<List<Dish>> getByList(Dish dish){
        LambdaQueryWrapper<Dish> wrapper = new LambdaQueryWrapper();
        wrapper.eq(dish.getCategoryId()!=null, Dish::getCategoryId, dish.getCategoryId());
        wrapper.like(StringUtils.isNotEmpty(dish.getName()), Dish::getName, dish.getName());
        List<Dish> list = dishService.list(wrapper);
        return R.success(list);
    }

}
