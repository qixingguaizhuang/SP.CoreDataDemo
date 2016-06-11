//
//  Clothes+CoreDataProperties.h
//  SP.CoreDataDemo
//
//  Created by sp on 16/5/3.
//  Copyright © 2016年 宋平. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Clothes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Clothes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSString *type;

@end

NS_ASSUME_NONNULL_END
