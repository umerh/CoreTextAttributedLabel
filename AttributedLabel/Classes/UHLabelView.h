//
//  UHLabelView.h
//  AttributedLabels
//
//  Created by Umer Sheikh on 10-06-13.
//  Copyright 2010 Eastern Heritage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface UHLabelView : UIView {
	NSAttributedString *_text;
	int _columnCount;
	BOOL _columnLineVisible;
	
	CGRect removePath;
	
	NSMutableArray *_frames;
}

@property (nonatomic) BOOL columnLineVisible;
@property (nonatomic,retain) NSAttributedString *text;
@property (nonatomic) int columnCount;


@end
