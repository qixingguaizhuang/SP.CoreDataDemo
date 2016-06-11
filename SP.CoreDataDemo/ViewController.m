//
//  ViewController.m
//  SP.CoreDataDemo
//
//  Created by sp on 16/5/3.
//  Copyright © 2016年 宋平. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Clothes.h"



@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewCell;
@property (nonatomic, strong)NSMutableArray *dataSource;

//app 写成属性可以调用 app 中的属性，例如 contenct
@property (nonatomic,strong)AppDelegate *myAppDelegate;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 初始化数组
    self.dataSource = [NSMutableArray array];
    // appDelegate 获取
    self.myAppDelegate = [UIApplication sharedApplication].delegate;

    // 查询数据
    // 1. NSFetchrequst 对象创建
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Clothes"];

    // 2.设置排序描述对象 升序
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc]initWithKey:@"price" ascending:YES];
    
    request.sortDescriptors = @[sortDescription];
    
    // 执行查询请求
    NSError *error = nil;
    // 返回数组， 用数组接受
  NSArray *result = [self.myAppDelegate.managedObjectContext executeFetchRequest:request error:&error];
  
    // 给数据源添加数据
    [self.dataSource addObjectsFromArray:result];

}

// 插入数据
- (IBAction)addMode:(id)sender {
    
    
    // 创建实体描述
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Clothes" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    
    
    //1. 先创建模型对象 clothes
    Clothes *cloth = [[Clothes alloc]initWithEntity:description insertIntoManagedObjectContext:self.myAppDelegate.managedObjectContext];
   
    // 2. 属性赋值
    cloth.name = @"Puma";
    
    // 价格
    int price = arc4random() % 1000 + 1;
    cloth.price = [NSNumber numberWithInt:price];
    
    // 插入数据
    [self.dataSource addObject:cloth];
    
    // 插入 UI cell
    [self.tableViewCell insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    
    
    
    // 对数据管理层的数据进行更改永久保存
    [self.myAppDelegate saveContext];
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Clothes *cloth = self.dataSource[indexPath.row];

    
    cell.textLabel.text = [NSString stringWithFormat:@"品牌名称： %@ - %@ 元", cloth.name, cloth.price];
    
    return cell;
}


// 允许tableview 编辑

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

// 编辑方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{


   
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 删除数据源
        Clothes *cloth = self.dataSource[indexPath.row];
        [self.dataSource removeObject:cloth];
        
        // 删除对应数据
        [self.myAppDelegate.managedObjectContext deleteObject:cloth];
        
        // 数据永久保存
        [self.myAppDelegate saveContext];
        
        // 删除单元格
        [self.tableViewCell deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }





}


// 点击 cell 的方法用来修改数据

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{


    // 查询模型对象
    Clothes *cloth = self.dataSource[indexPath.row];

    // 更改
    cloth.name = @"NIKE";
    
    // 刷新 UI 单元行
    [self.tableViewCell reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    // 对数据永久保存
    [self.myAppDelegate saveContext];
    
}


// 模型数据迁移






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
