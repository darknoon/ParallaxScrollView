//
//  ParallaxViewController.m
//  ParallaxScrollView
//
//  Created by Andrew Pouliot on 1/7/13.
//  Copyright (c) 2013 Darknoon. All rights reserved.
//

#import "ParallaxViewController.h"
#import "ParallaxCell.h"

static NSString *ImageCell = @"Image";
static NSString *TextCell = @"Text";

@interface ParallaxViewController ()

@end

@implementation ParallaxViewController {
	NSArray *_images;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	//Load images
	NSMutableArray *imagesMutable = [[NSMutableArray alloc] init];
	NSArray *imagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@"images"];
	for (NSString *path  in imagePaths) {
		[imagesMutable addObject:[[UIImage alloc] initWithContentsOfFile:path]];
	}
	_images = imagesMutable;

	[self.tableView registerClass:[ParallaxCell class] forCellReuseIdentifier:ImageCell];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TextCell];
	
	self.tableView.rowHeight = 60.0;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL imageCell = indexPath.row % 2 == 1;
	
	if (imageCell) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCell forIndexPath:indexPath];
		
		cell.imageView.image = _images[(indexPath.row / 2) % _images.count];
		return cell;
	} else {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCell forIndexPath:indexPath];
		cell.textLabel.text = @"Text";
		return cell;
	}	
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
	for (NSIndexPath *indexPath in self.tableView.indexPathsForVisibleRows) {
		BOOL imageCell = indexPath.row % 2 == 1;
		if (imageCell) {
			ParallaxCell *cell = (ParallaxCell *)[self.tableView cellForRowAtIndexPath:indexPath];
			CGRect cellRect = [self.tableView convertRect:[self.tableView rectForRowAtIndexPath:indexPath] toView:self.tableView.superview];
			cell.offset = cellRect.origin.y;
			cell.totalHeight = self.tableView.frame.size.height;
		}
	}
}

@end
