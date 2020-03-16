#import "Isrooted.h"

@implementation Isrooted
  
  RCT_EXPORT_MODULE();
  
  BOOL isJailbroken()
  
  {
#if TARGET_OS_SIMULATOR
    // Simulator-specific code
    //alert and exit
    
    return YES;
    
#else
    // #if !(TARGET_IPHONE_SIMULATOR)
    
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"] ||
        
        [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"] ||
        
        [[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"] ||
        
        [[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"] ||
        
        [[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"] ||
        
        [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] ||
        
        [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]])  {
      
      return YES;
      
    }
    
    
    
    FILE *f = NULL ;
    
    if ((f = fopen("/bin/bash", "r")) ||
        
        (f = fopen("/Applications/Cydia.app", "r")) ||
        
        (f = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r")) ||
        
        (f = fopen("/usr/sbin/sshd", "r")) ||
        
        (f = fopen("/etc/apt", "r")))  {
      
      fclose(f);
      
      return YES;
      
    }
    
    fclose(f);
    
    
    
    NSError *error;
    
    NSString *stringToBeWritten = @"This is a test.";
    
    [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
    
    if(error == nil)
    
    {
      
      return YES;
      
    }
    
    
    
#endif
    
    
    
    return NO;
    
  }
  
  
  
  RCT_REMAP_METHOD(isRooted,findEventsWithResolver: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    
    @try{
      
      BOOL isJailBorken = isJailbroken();
      resolve(isJailBorken == YES ? @"1" : @"0");
      
    }
    
    @catch(NSException *exception){
      
      NSMutableDictionary * info = [NSMutableDictionary dictionary];
      
      [info setValue:exception.name forKey:@"ExceptionName"];
      
      [info setValue:exception.reason forKey:@"ExceptionReason"];
      
      [info setValue:exception.userInfo forKey:@"ExceptionUserInfo"];
      
      
      
      NSError *error = [[NSError alloc] initWithDomain:@"Root Detection Module" code:0 userInfo:info];
      
      reject(@"failed to execute",@"",error);
      
    }
    
    
    
  }
  @end
