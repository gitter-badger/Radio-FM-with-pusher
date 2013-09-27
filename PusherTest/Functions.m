//
//  Functions.m
//  Sunflower Ingatlan
//
//  Created by Rusznyák Gábor on 2010.05.30..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Functions.h"

@implementation Functions

+ (BOOL)connectedToNetwork {
	return [Functions connectedToNetwork:@"http://swguru.hu"];
}

+ (BOOL)connectedToNetwork:(NSString *)url {
	NSURL *myURL=[NSURL URLWithString:url];
	NSURLRequest *myURLRequest=[NSURLRequest requestWithURL:myURL 
												cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
											timeoutInterval:5];
	NSError *error;
	NSData *myData=[NSURLConnection sendSynchronousRequest:myURLRequest 
												   returningResponse:nil 
															   error:&error];
	BOOL connected=(myData==NULL)?NO:YES;
	if (!connected) {
		UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"Hálózat" message:@"A hálózat nem elérhető!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[myAlert show];
	}
	return connected;
}

+ (NSData *)loadDataFromURL:(NSString *)url {
	NSURL *myURL=[NSURL URLWithString:url];
	NSURLRequest *myURLRequest=[NSURLRequest requestWithURL:myURL
												cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
											timeoutInterval:10];
	NSError *error;
	NSData *myData=[NSURLConnection sendSynchronousRequest:myURLRequest
                                         returningResponse:nil
                                                     error:&error];
	return myData;
}

+ (NSString *)loadStringFromURL:(NSString *)url {
	NSData *myData=[Functions loadDataFromURL:url];
	return [[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding];
    //return [NSString stringWithUTF8String:[myData bytes]];
}

+ (void)alert:(NSString *)message {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Figyelem!"
                                                  message:message
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [alert show];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *)path2doc {
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];	
}

@end
