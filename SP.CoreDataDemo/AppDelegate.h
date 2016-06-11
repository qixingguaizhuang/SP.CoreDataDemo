//
//  AppDelegate.h
//  SP.CoreDataDemo
//
//  Created by sp on 16/5/3.
//  Copyright © 2016年 宋平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 被管理对象上下文（数据管理器）相当于一个临时的数据库
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//被管理对象模型 （数据模型器）
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久化存储助理（数据链接器）CoreData 框架的核心
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// 把我们临时数据库中的内容改变进行永久保存
- (void)saveContext;
// 获取文件的存储路径，格式为 URL 类型的
- (NSURL *)applicationDocumentsDirectory;


@end

