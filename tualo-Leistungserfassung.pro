TEMPLATE = app

QT += qml quick multimedia sql declarative
SOURCES += main.cpp



OTHER_FILES += \
    qmldir \
    plugins.qmltypes


RESOURCES += qml.qrc

ICON = image_resources/osx_icon.icns
 
# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
#include ('qzxing/QZXing.pri')

LIBS += -liconv

PWD_QZXing = $$PWD/QZXing

INCLUDEPATH  += $$PWD_QZXing \
                $$PWD_QZXing/zxing


HEADERS += $$PWD_QZXing/QZXing_global.h \
    $$PWD_QZXing/CameraImageWrapper.h \
    $$PWD_QZXing/imagehandler.h \
    $$PWD_QZXing/QZXing.h \
    $$PWD_QZXing/zxing/zxing/ZXing.h \
    $$PWD_QZXing/zxing/zxing/IllegalStateException.h \
    $$PWD_QZXing/zxing/zxing/InvertedLuminanceSource.h \
    $$PWD_QZXing/zxing/zxing/ChecksumException.h \
    $$PWD_QZXing/zxing/zxing/ResultPointCallback.h \
    $$PWD_QZXing/zxing/zxing/ResultPoint.h \
    $$PWD_QZXing/zxing/zxing/Result.h \
    $$PWD_QZXing/zxing/zxing/ReaderException.h \
    $$PWD_QZXing/zxing/zxing/Reader.h \
    $$PWD_QZXing/zxing/zxing/NotFoundException.h \
    $$PWD_QZXing/zxing/zxing/MultiFormatReader.h \
    $$PWD_QZXing/zxing/zxing/LuminanceSource.h \
    $$PWD_QZXing/zxing/zxing/FormatException.h \
    $$PWD_QZXing/zxing/zxing/Exception.h \
    $$PWD_QZXing/zxing/zxing/DecodeHints.h \
    $$PWD_QZXing/zxing/zxing/BinaryBitmap.h \
    $$PWD_QZXing/zxing/zxing/Binarizer.h \
    $$PWD_QZXing/zxing/zxing/BarcodeFormat.h \
    $$PWD_QZXing/zxing/zxing/aztec/AztecReader.h \
    $$PWD_QZXing/zxing/zxing/aztec/AztecDetectorResult.h \
    $$PWD_QZXing/zxing/zxing/aztec/decoder/Decoder.h \
    $$PWD_QZXing/zxing/zxing/aztec/detector/Detector.h \
    $$PWD_QZXing/zxing/zxing/common/StringUtils.h \
    $$PWD_QZXing/zxing/zxing/common/Str.h \
    $$PWD_QZXing/zxing/zxing/common/Point.h \
    $$PWD_QZXing/zxing/zxing/common/PerspectiveTransform.h \
    $$PWD_QZXing/zxing/zxing/common/IllegalArgumentException.h \
    $$PWD_QZXing/zxing/zxing/common/HybridBinarizer.h \
    $$PWD_QZXing/zxing/zxing/common/GridSampler.h \
    $$PWD_QZXing/zxing/zxing/common/GreyscaleRotatedLuminanceSource.h \
    $$PWD_QZXing/zxing/zxing/common/GreyscaleLuminanceSource.h \
    $$PWD_QZXing/zxing/zxing/common/GlobalHistogramBinarizer.h \
    $$PWD_QZXing/zxing/zxing/common/DetectorResult.h \
    $$PWD_QZXing/zxing/zxing/common/DecoderResult.h \
    $$PWD_QZXing/zxing/zxing/common/Counted.h \
    $$PWD_QZXing/zxing/zxing/common/CharacterSetECI.h \
    $$PWD_QZXing/zxing/zxing/common/BitSource.h \
    $$PWD_QZXing/zxing/zxing/common/BitMatrix.h \
    $$PWD_QZXing/zxing/zxing/common/BitArray.h \
    $$PWD_QZXing/zxing/zxing/common/Array.h \
    $$PWD_QZXing/zxing/zxing/common/detector/MathUtils.h \
    $$PWD_QZXing/zxing/zxing/common/detector/JavaMath.h \
    $$PWD_QZXing/zxing/zxing/common/detector/WhiteRectangleDetector.h \
    $$PWD_QZXing/zxing/zxing/common/detector/MonochromeRectangleDetector.h \
    $$PWD_QZXing/zxing/zxing/common/reedsolomon/ReedSolomonException.h \
    $$PWD_QZXing/zxing/zxing/common/reedsolomon/ReedSolomonDecoder.h \
    $$PWD_QZXing/zxing/zxing/common/reedsolomon/GenericGFPoly.h \
    $$PWD_QZXing/zxing/zxing/common/reedsolomon/GenericGF.h \
    $$PWD_QZXing/zxing/zxing/datamatrix/Version.h \
    $$PWD_QZXing/zxing/zxing/datamatrix/DataMatrixReader.h \
    $$PWD_QZXing/zxing/zxing/datamatrix/decoder/Decoder.h \
    $$PWD_QZXing/zxing/zxing/datamatrix/decoder/DecodedBitStreamParser.h \
    $$PWD_QZXing/zxing/zxing/datamatrix/decoder/DataBlock.h \
    $$PWD_QZXing/zxing/zxing/datamatrix/decoder/BitMatrixParser.h \
    $$PWD_QZXing/zxing/zxing/datamatrix/detector/DetectorException.h \
    $$PWD_QZXing/zxing/zxing/datamatrix/detector/Detector.h \
    $$PWD_QZXing/zxing/zxing/datamatrix/detector/CornerPoint.h \
    $$PWD_QZXing/zxing/zxing/oned/UPCEReader.h \
    $$PWD_QZXing/zxing/zxing/oned/UPCEANReader.h \
    $$PWD_QZXing/zxing/zxing/oned/UPCAReader.h \
    $$PWD_QZXing/zxing/zxing/oned/OneDResultPoint.h \
    $$PWD_QZXing/zxing/zxing/oned/OneDReader.h \
    $$PWD_QZXing/zxing/zxing/oned/MultiFormatUPCEANReader.h \
    $$PWD_QZXing/zxing/zxing/oned/MultiFormatOneDReader.h \
    $$PWD_QZXing/zxing/zxing/oned/ITFReader.h \
    $$PWD_QZXing/zxing/zxing/oned/EAN13Reader.h \
    $$PWD_QZXing/zxing/zxing/oned/EAN8Reader.h \
    $$PWD_QZXing/zxing/zxing/oned/Code128Reader.h \
    $$PWD_QZXing/zxing/zxing/oned/Code39Reader.h \
    $$PWD_QZXing/zxing/zxing/oned/CodaBarReader.h \
    $$PWD_QZXing/zxing/zxing/oned/Code93Reader.h \
    $$PWD_QZXing/zxing/zxing/qrcode/Version.h \
    $$PWD_QZXing/zxing/zxing/qrcode/QRCodeReader.h \
    $$PWD_QZXing/zxing/zxing/qrcode/FormatInformation.h \
    $$PWD_QZXing/zxing/zxing/qrcode/ErrorCorrectionLevel.h \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/Mode.h \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/Decoder.h \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/DecodedBitStreamParser.h \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/DataMask.h \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/DataBlock.h \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/BitMatrixParser.h \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/FinderPatternInfo.h \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/FinderPatternFinder.h \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/FinderPattern.h \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/Detector.h \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/AlignmentPatternFinder.h \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/AlignmentPattern.h \
    $$PWD_QZXing/zxing/zxing/multi/MultipleBarcodeReader.h \
    $$PWD_QZXing/zxing/zxing/multi/GenericMultipleBarcodeReader.h \
    $$PWD_QZXing/zxing/zxing/multi/ByQuadrantReader.h \
    $$PWD_QZXing/zxing/zxing/multi/qrcode/QRCodeMultiReader.h \
    $$PWD_QZXing/zxing/zxing/multi/qrcode/detector/MultiFinderPatternFinder.h \
    $$PWD_QZXing/zxing/zxing/multi/qrcode/detector/MultiDetector.h \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/ec/ErrorCorrection.h \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/ec/ModulusGF.h \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/ec/ModulusPoly.h \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/BitMatrixParser.h \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/DecodedBitStreamParser.h \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/Decoder.h \
    $$PWD_QZXing/zxing/zxing/pdf417/detector/Detector.h \
    $$PWD_QZXing/zxing/zxing/pdf417/detector/LinesSampler.h \
    $$PWD_QZXing/zxing/zxing/pdf417/PDF417Reader.h \
    $$PWD_QZXing/zxing/bigint/NumberlikeArray.hh \
    $$PWD_QZXing/zxing/bigint/BigUnsignedInABase.hh \
    $$PWD_QZXing/zxing/bigint/BigUnsigned.hh \
    $$PWD_QZXing/zxing/bigint/BigIntegerUtils.hh \
    $$PWD_QZXing/zxing/bigint/BigIntegerLibrary.hh \
    $$PWD_QZXing/zxing/bigint/BigIntegerAlgorithms.hh \
    $$PWD_QZXing/zxing/bigint/BigInteger.hh

SOURCES += $$PWD_QZXing/CameraImageWrapper.cpp \
    $$PWD_QZXing/qzxing.cpp \
    $$PWD_QZXing/imagehandler.cpp \
    $$PWD_QZXing/zxing/zxing/ResultIO.cpp \
    $$PWD_QZXing/zxing/zxing/InvertedLuminanceSource.cpp \
    $$PWD_QZXing/zxing/zxing/ChecksumException.cpp \
    $$PWD_QZXing/zxing/zxing/ResultPointCallback.cpp \
    $$PWD_QZXing/zxing/zxing/ResultPoint.cpp \
    $$PWD_QZXing/zxing/zxing/Result.cpp \
    $$PWD_QZXing/zxing/zxing/Reader.cpp \
    $$PWD_QZXing/zxing/zxing/MultiFormatReader.cpp \
    $$PWD_QZXing/zxing/zxing/LuminanceSource.cpp \
    $$PWD_QZXing/zxing/zxing/FormatException.cpp \
    $$PWD_QZXing/zxing/zxing/Exception.cpp \
    $$PWD_QZXing/zxing/zxing/DecodeHints.cpp \
    $$PWD_QZXing/zxing/zxing/BinaryBitmap.cpp \
    $$PWD_QZXing/zxing/zxing/Binarizer.cpp \
    $$PWD_QZXing/zxing/zxing/BarcodeFormat.cpp \
    $$PWD_QZXing/zxing/zxing/aztec/AztecReader.cpp \
    $$PWD_QZXing/zxing/zxing/aztec/AztecDetectorResult.cpp \
    $$PWD_QZXing/zxing/zxing/common/StringUtils.cpp \
    $$PWD_QZXing/zxing/zxing/common/Str.cpp \
    $$PWD_QZXing/zxing/zxing/common/PerspectiveTransform.cpp \
    $$PWD_QZXing/zxing/zxing/common/IllegalArgumentException.cpp \
    $$PWD_QZXing/zxing/zxing/common/HybridBinarizer.cpp \
    $$PWD_QZXing/zxing/zxing/common/GridSampler.cpp \
    $$PWD_QZXing/zxing/zxing/common/GreyscaleRotatedLuminanceSource.cpp \
    $$PWD_QZXing/zxing/zxing/common/GreyscaleLuminanceSource.cpp \
    $$PWD_QZXing/zxing/zxing/common/GlobalHistogramBinarizer.cpp \
    $$PWD_QZXing/zxing/zxing/common/DetectorResult.cpp \
    $$PWD_QZXing/zxing/zxing/common/DecoderResult.cpp \
    $$PWD_QZXing/zxing/zxing/common/CharacterSetECI.cpp \
    $$PWD_QZXing/zxing/zxing/common/BitSource.cpp \
    $$PWD_QZXing/zxing/zxing/common/BitMatrix.cpp \
    $$PWD_QZXing/zxing/zxing/common/BitArray.cpp \
    $$PWD_QZXing/zxing/zxing/common/BitArrayIO.cpp \
    $$PWD_QZXing/zxing/zxing/common/detector/WhiteRectangleDetector.cpp \
    $$PWD_QZXing/zxing/zxing/common/detector/MonochromeRectangleDetector.cpp \
    $$PWD_QZXing/zxing/zxing/common/reedsolomon/ReedSolomonException.cpp \
    $$PWD_QZXing/zxing/zxing/common/reedsolomon/ReedSolomonDecoder.cpp \
    $$PWD_QZXing/zxing/zxing/common/reedsolomon/GenericGFPoly.cpp \
    $$PWD_QZXing/zxing/zxing/common/reedsolomon/GenericGF.cpp \
    $$PWD_QZXing/zxing/zxing/datamatrix/DataMatrixReader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/UPCEReader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/UPCEANReader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/UPCAReader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/OneDResultPoint.cpp \
    $$PWD_QZXing/zxing/zxing/oned/OneDReader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/MultiFormatUPCEANReader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/MultiFormatOneDReader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/ITFReader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/EAN13Reader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/EAN8Reader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/Code128Reader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/Code39Reader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/CodaBarReader.cpp \
    $$PWD_QZXing/zxing/zxing/oned/Code93Reader.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/QRCodeReader.cpp \
    $$PWD_QZXing/zxing/zxing/multi/MultipleBarcodeReader.cpp \
    $$PWD_QZXing/zxing/zxing/multi/GenericMultipleBarcodeReader.cpp \
    $$PWD_QZXing/zxing/zxing/multi/ByQuadrantReader.cpp \
    $$PWD_QZXing/zxing/zxing/multi/qrcode/QRCodeMultiReader.cpp \
    $$PWD_QZXing/zxing/zxing/multi/qrcode/detector/MultiFinderPatternFinder.cpp \
    $$PWD_QZXing/zxing/zxing/multi/qrcode/detector/MultiDetector.cpp \
    $$PWD_QZXing/zxing/zxing/aztec/decoder/AztecDecoder.cpp \
    $$PWD_QZXing/zxing/zxing/aztec/detector/AztecDetector.cpp \
    $$PWD_QZXing/zxing/zxing/datamatrix/DataMatrixVersion.cpp \
    $$PWD_QZXing/zxing/zxing/datamatrix/decoder/DataMatrixDecoder.cpp \
    $$PWD_QZXing/zxing/zxing/datamatrix/decoder/DataMatrixBitMatrixParser.cpp \
    $$PWD_QZXing/zxing/zxing/datamatrix/decoder/DataMatrixDataBlock.cpp \
    $$PWD_QZXing/zxing/zxing/datamatrix/decoder/DataMatrixDecodedBitStreamParser.cpp \
    $$PWD_QZXing/zxing/zxing/datamatrix/detector/DataMatrixCornerPoint.cpp \
    $$PWD_QZXing/zxing/zxing/datamatrix/detector/DataMatrixDetector.cpp \
    $$PWD_QZXing/zxing/zxing/datamatrix/detector/DataMatrixDetectorException.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/QRBitMatrixParser.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/QRDataBlock.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/QRDataMask.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/QRDecodedBitStreamParser.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/QRDecoder.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/decoder/QRMode.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/QRAlignmentPattern.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/QRAlignmentPatternFinder.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/QRDetector.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/QRFinderPattern.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/QRFinderPatternFinder.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/detector/QRFinderPatternInfo.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/QRVersion.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/QRFormatInformation.cpp \
    $$PWD_QZXing/zxing/zxing/qrcode/QRErrorCorrectionLevel.cpp \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/ec/ErrorCorrection.cpp \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/ec/ModulusGF.cpp \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/ec/ModulusPoly.cpp \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/PDF417BitMatrixParser.cpp \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/PDF417DecodedBitStreamParser.cpp \
    $$PWD_QZXing/zxing/zxing/pdf417/decoder/PDF417Decoder.cpp \
    $$PWD_QZXing/zxing/zxing/pdf417/detector/PDF417Detector.cpp \
    $$PWD_QZXing/zxing/zxing/pdf417/detector/LinesSampler.cpp \
    $$PWD_QZXing/zxing/zxing/pdf417/PDF417Reader.cpp \
    $$PWD_QZXing/zxing/bigint/BigUnsignedInABase.cc \
    $$PWD_QZXing/zxing/bigint/BigUnsigned.cc \
    $$PWD_QZXing/zxing/bigint/BigIntegerUtils.cc \
    $$PWD_QZXing/zxing/bigint/BigIntegerAlgorithms.cc \
    $$PWD_QZXing/zxing/bigint/BigInteger.cc


ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android



OTHER_FILES += \
    android/AndroidManifest.xml \
    android/res/drawable-xxhdpi/icon.png \
    android/res/drawable-xhdpi/icon.png \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/res/drawable-ldpi/icon.png \
    android/res/values/strings.xml \
    resource.rc



win32:RC_FILE = resource.rc
