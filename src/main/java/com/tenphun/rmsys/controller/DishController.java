package com.tenphun.rmsys.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tenphun.rmsys.common.R;
import com.tenphun.rmsys.dto.DishDto;
import com.tenphun.rmsys.entity.Dish;
import com.tenphun.rmsys.entity.DishFlavor;
import com.tenphun.rmsys.service.DishFlavorService;
import com.tenphun.rmsys.service.DishService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/dish")
public class DishController {

    @Autowired
    DishService dishService;
    @Autowired
    DishFlavorService dishFlavorService;

    @GetMapping("/page")
    public R<Page<DishDto>> page (int page, int pageSize, String name){
        Page<DishDto> pageInfo = new Page<>(page, pageSize);

        LambdaQueryWrapper<DishDto> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotEmpty(name), DishDto::getName, name);
        wrapper.orderByDesc(DishDto::getUpdateTime);
        return R.success(pageInfo);
    }

    @PostMapping
    public R<String> add(@RequestBody DishDto dishDto){
        dishService.saveWithFlavor(dishDto);

        return R.success("Add 1");
    }

}
