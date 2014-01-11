//
//  OTBViewController.m
//  Tasks
//
//  Created by Chuck J Hardy on 11/01/2014.
//  Copyright (c) 2014 Chuck J Hardy. All rights reserved.
//

#import "OTBTasksViewController.h"

@interface OTBTasksViewController ()

@end

@implementation OTBTasksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Item"];
    return cell;
}

@end
