    //
//  MainViewController.m
//  AttributedLabels
//
//  Created by Umer Sheikh on 10-06-13.
//  Copyright 2010 Eastern Heritage. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	contentView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
	label = [[UHLabelView alloc] initWithFrame: CGRectMake(0, 100, 1024, 748-100)];
	
	NSString *fileUrl = [[NSBundle mainBundle] pathForResource:@"TextFile" ofType:@"txt"];
	NSString *text = [NSString stringWithContentsOfFile:fileUrl encoding:NSUTF8StringEncoding error:NULL];
	
	
	
	NSMutableAttributedString *_text = [[NSMutableAttributedString alloc] initWithString:text];
	CTFontRef font = CTFontCreateWithName((CFStringRef)@"Georgia", 20, NULL);
	[_text addAttribute:(id)kCTFontAttributeName value:(id)font range:NSMakeRange(0, [_text length])];
	[_text addAttribute:(id)kCTForegroundColorAttributeName value:(id)[[UIColor darkGrayColor] CGColor] range:NSMakeRange(0, [_text length]/2)];
	[_text addAttribute:(id)kCTForegroundColorAttributeName value:(id)[[UIColor purpleColor] CGColor] range:NSMakeRange([_text length]/2, [_text length]/2-1)];
	
	// OK, This is freaky but just set the paragraph style below
	CTTextAlignment alignment = kCTJustifiedTextAlignment;
	CGFloat paragraphSpacing = 1.0;
	CTParagraphStyleSetting settings[] = {
		{kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment},						// Justified Text Alignment
		{kCTParagraphStyleSpecifierParagraphSpacing, sizeof(paragraphSpacing), &paragraphSpacing}	// 1.0 Paragraph Spacing
	};
	CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
	[_text addAttribute:(id)kCTParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_text length])];

	[label setBackgroundColor:[UIColor clearColor]];
	[label setColumnCount:4];							// Set the Number of Columns
	[label setBackgroundColor:[UIColor whiteColor]];
	[label setText:_text];
	[contentView addSubview:label];
	
	
	label2 = [[UHLabelView alloc] initWithFrame:CGRectMake(0, 0, 1024, 100)];
	NSMutableAttributedString *_t2 = [[NSMutableAttributedString alloc] initWithString:@"Umer's Tech News"];
	alignment = kCTCenterTextAlignment;
	CTParagraphStyleSetting settings2[] = {
		{kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment}
	};
	 paragraphStyle = CTParagraphStyleCreate(settings2, sizeof(settings2) / sizeof(settings2[0]));
	[_t2 addAttribute:(id)kCTParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_t2 length])];
	[_t2 addAttribute:(id)kCTForegroundColorAttributeName value:(id)[[UIColor blackColor] CGColor] range:NSMakeRange(0, [_t2 length])];
	[_t2 addAttribute:(id)kCTFontAttributeName value:(id)font range:NSMakeRange(0, [_t2 length])];
	
	CTFontRef font2 = CTFontCreateWithName((CFStringRef)@"Helvetica", 64, NULL);
	[_t2 addAttribute:(id)kCTFontAttributeName value:(id)font2 range:NSMakeRange(0, [_t2 length])];
	
	label2.text = _t2 ;
	[contentView addSubview:label2];
	
	UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 95, 1024-20, 1)];
	line.backgroundColor = [UIColor blackColor];
	[contentView addSubview:line];
	[line release];
	
	/*
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2];
	[UIView setAnimationRepeatCount:20];
	[UIView	setAnimationRepeatAutoreverses:YES];
	
	label.frame = CGRectMake(25, 25, 1000, 400);
	
	[UIView commitAnimations];
	*/
	
	//[label release];
	
	CFRelease(font);
	CFRelease(font2);
	
	self.view = contentView;
	[contentView release];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
	
	if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
		contentView.frame = CGRectMake(0, 0, 768, 1004);
		label2.frame = CGRectMake(0, 0, 768, 100);
		label.frame = CGRectMake(0, 100, 768, 1004-100);
	} else {
		contentView.frame = CGRectMake(0, 0, 1024, 748);
		label2.frame = CGRectMake(0, 0, 1024, 100);		
		label.frame = CGRectMake(0, 100, 1024, 748-100);
	}
	
	
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
