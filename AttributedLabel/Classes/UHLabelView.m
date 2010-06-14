//
//  UHLabelView.m
//  AttributedLabels
//
//  Created by Umer Sheikh on 10-06-13.
//  Copyright 2010 Eastern Heritage. All rights reserved.
//

#import "UHLabelView.h"


@implementation UHLabelView
@synthesize text = _text;
@synthesize columnCount = _columnCount;
@synthesize columnLineVisible = _columnLineVisible;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		_columnCount = 1;
		self.backgroundColor = [UIColor groupTableViewBackgroundColor];		
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

-(void)setFrame:(CGRect)rect {
	[super setFrame:rect];
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Draw a white background.
    UIColor *c = self.backgroundColor;
	[c set];
	UIRectFill(self.bounds);
	
    // Initialize the text matrix to a known value.
    CGContextRef context = (CGContextRef)UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	
    CTFramesetterRef framesetter =
	CTFramesetterCreateWithAttributedString((CFAttributedStringRef)[self text]);
    CFArrayRef columnPaths = [self createColumns];
	
    CFIndex pathCount = CFArrayGetCount(columnPaths);
    CFIndex startIndex = 0;
	
	int column = 0;
	for (column = 0; column < pathCount-1; column++) {
		CGPathRef path = (CGPathRef)CFArrayGetValueAtIndex(columnPaths, column);
		CGRect rc = CGPathGetBoundingBox(path);
		[[UIColor blackColor] set];
		CGContextFillRect(context, CGRectMake(rc.origin.x+rc.size.width+8, 10, 1, rc.size.height));
		
	}
	
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CGContextTranslateCTM(context, 0, self.frame.size.height);
	CGContextScaleCTM(context, 1, -1);
	
	_frames = [[NSMutableArray alloc] init];
    for (column = 0; column < pathCount; column++) {
        CGPathRef path = (CGPathRef)CFArrayGetValueAtIndex(columnPaths, column);
		
        // Create a frame for this column and draw it.
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
													CFRangeMake(startIndex, 0), path, NULL);
        CTFrameDraw(frame, context);
		
		
        // Start the next frame at the first character not visible in this frame.
        CFRange frameRange = CTFrameGetVisibleStringRange(frame);
        startIndex += frameRange.length;
		
        //CFRelease(frame);
		
		[_frames addObject:(id)frame];
    }
    CFRelease(columnPaths);
}

- (void)drawScaledContent:(CGRect)rect;
{
    // Updated by -drawRect:
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIColor *background = self.backgroundColor;
    if (background) {
        [background setFill];
        CGContextFillRect(ctx, rect);
    }
    
    /* We want to draw any range selections under the text, and we want to draw insertion carets (non-range selections) and markedText hairlines over the text. */
    
	CGPoint layoutOrigin = CGPointMake(10, self.frame.origin.y);
    CGContextTranslateCTM(ctx, layoutOrigin.x, layoutOrigin.y);
    CGContextSetTextPosition(ctx, 0, 0);
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
	
    CTFrameDraw([_frames objectAtIndex:0], ctx);
	//[self.layer renderInContext:ctx];
    CGContextTranslateCTM(ctx, -layoutOrigin.x, -layoutOrigin.y);
    
}

-(void)removeRect:(CGRect)rect {
	removePath = rect;
}


- (CFArrayRef)createColumns {
    CGRect _bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    int column;
    CGRect* columnRects = (CGRect*)calloc(_columnCount, sizeof(*columnRects));
	
    // Start by setting the first column to cover the entire view.
    columnRects[0] = _bounds;
    // Divide the columns equally across the frame's width.
    CGFloat columnWidth = CGRectGetWidth(_bounds) / _columnCount;
    for (column = 0; column < _columnCount - 1; column++) {
        CGRectDivide(columnRects[column], &columnRects[column],
                     &columnRects[column + 1], columnWidth, CGRectMinXEdge);
    }
	
    // Inset all columns by a few pixels of margin.
    for (column = 0; column < _columnCount; column++) {
        columnRects[column] = CGRectInset(columnRects[column], 10.0, 10.0);
    }
	
	// Create an array of layout paths, one for each column.
    CFMutableArrayRef array = CFArrayCreateMutable(kCFAllocatorDefault,
												   _columnCount, &kCFTypeArrayCallBacks);
    for (column = 0; column < _columnCount; column++) {
        CGMutablePathRef path = CGPathCreateMutable();
		
		//CGPathAddArcToPoint(path, NULL, columnRects[column].origin.x, columnRects[column].origin.y, 55, 100, 5);
		
        CGPathAddRect(path, NULL, columnRects[column]);
        CFArrayInsertValueAtIndex(array, column, path);
        CFRelease(path);
    }
    free(columnRects);
    return array;
}

@end
