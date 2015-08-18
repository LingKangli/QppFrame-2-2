//
//  PictureOpr.h
//  QppFrame
//
//  Created by LingKangLi on 15/8/13.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#ifndef QppFrame_PictureOpr_h
#define QppFrame_PictureOpr_h

#define test(a,b) \
{        \
typeof (a) _a = (a); \
typeof (b) _b = (b); \
(_a < _b) ? _a : _b; \
}

#define ImgToData(imgString)\
{ UIImageJPEGRepresentation(imgString, 1.0) \
}

#endif
