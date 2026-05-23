#!/usr/bin/env python3
"""Adds WaterWidgetExtension target to ios/Runner.xcodeproj/project.pbxproj (no Mac/Xcode required)."""

from pathlib import Path

PBX = Path(__file__).resolve().parents[1] / "ios" / "Runner.xcodeproj" / "project.pbxproj"

MARKER = "/* End PBXNativeTarget section */"

WIDGET_BUILD_CONFIGS = """\
\t\tA1WGT0011CF9000F007C0015 /* Debug */ = {
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {
\t\t\t\tASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
\t\t\t\tASSETCATALOG_COMPILER_WIDGET_BACKGROUND_COLOR_NAME = WidgetBackground;
\t\t\t\tCLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
\t\t\t\tCLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
\t\t\t\tCLANG_ENABLE_OBJC_WEAK = YES;
\t\t\t\tCLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
\t\t\t\tCODE_SIGN_ENTITLEMENTS = WaterWidgetExtension.entitlements;
\t\t\t\tCODE_SIGN_STYLE = Automatic;
\t\t\t\tCURRENT_PROJECT_VERSION = "$(FLUTTER_BUILD_NUMBER)";
\t\t\t\tGENERATE_INFOPLIST_FILE = YES;
\t\t\t\tINFOPLIST_FILE = WaterWidget/Info.plist;
\t\t\t\tINFOPLIST_KEY_CFBundleDisplayName = Water;
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 16.0;
\t\t\t\tLD_RUNPATH_SEARCH_PATHS = (
\t\t\t\t\t"$(inherited)",
\t\t\t\t\t"@executable_path/Frameworks",
\t\t\t\t\t"@executable_path/../../Frameworks",
\t\t\t\t);
\t\t\t\tMARKETING_VERSION = "$(FLUTTER_BUILD_NAME)";
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = com.nexushealthlabs.waterreminder.WaterWidget;
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tSKIP_INSTALL = YES;
\t\t\t\tSWIFT_EMIT_LOC_STRINGS = YES;
\t\t\t\tSWIFT_VERSION = 5.0;
\t\t\t\tTARGETED_DEVICE_FAMILY = "1,2";
\t\t\t};
\t\t\tname = Debug;
\t\t};
\t\tA1WGT0011CF9000F007C0016 /* Release */ = {
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {
\t\t\t\tASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
\t\t\t\tASSETCATALOG_COMPILER_WIDGET_BACKGROUND_COLOR_NAME = WidgetBackground;
\t\t\t\tCLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
\t\t\t\tCLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
\t\t\t\tCLANG_ENABLE_OBJC_WEAK = YES;
\t\t\t\tCLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
\t\t\t\tCODE_SIGN_ENTITLEMENTS = WaterWidgetExtension.entitlements;
\t\t\t\tCODE_SIGN_STYLE = Automatic;
\t\t\t\tCURRENT_PROJECT_VERSION = "$(FLUTTER_BUILD_NUMBER)";
\t\t\t\tGENERATE_INFOPLIST_FILE = YES;
\t\t\t\tINFOPLIST_FILE = WaterWidget/Info.plist;
\t\t\t\tINFOPLIST_KEY_CFBundleDisplayName = Water;
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 16.0;
\t\t\t\tLD_RUNPATH_SEARCH_PATHS = (
\t\t\t\t\t"$(inherited)",
\t\t\t\t\t"@executable_path/Frameworks",
\t\t\t\t\t"@executable_path/../../Frameworks",
\t\t\t\t);
\t\t\t\tMARKETING_VERSION = "$(FLUTTER_BUILD_NAME)";
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = com.nexushealthlabs.waterreminder.WaterWidget;
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tSKIP_INSTALL = YES;
\t\t\t\tSWIFT_EMIT_LOC_STRINGS = YES;
\t\t\t\tSWIFT_VERSION = 5.0;
\t\t\t\tTARGETED_DEVICE_FAMILY = "1,2";
\t\t\t};
\t\t\tname = Release;
\t\t};
\t\tA1WGT0011CF9000F007C0017 /* Profile */ = {
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {
\t\t\t\tASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
\t\t\t\tASSETCATALOG_COMPILER_WIDGET_BACKGROUND_COLOR_NAME = WidgetBackground;
\t\t\t\tCLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
\t\t\t\tCLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
\t\t\t\tCLANG_ENABLE_OBJC_WEAK = YES;
\t\t\t\tCLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
\t\t\t\tCODE_SIGN_ENTITLEMENTS = WaterWidgetExtension.entitlements;
\t\t\t\tCODE_SIGN_STYLE = Automatic;
\t\t\t\tCURRENT_PROJECT_VERSION = "$(FLUTTER_BUILD_NUMBER)";
\t\t\t\tGENERATE_INFOPLIST_FILE = YES;
\t\t\t\tINFOPLIST_FILE = WaterWidget/Info.plist;
\t\t\t\tINFOPLIST_KEY_CFBundleDisplayName = Water;
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 16.0;
\t\t\t\tLD_RUNPATH_SEARCH_PATHS = (
\t\t\t\t\t"$(inherited)",
\t\t\t\t\t"@executable_path/Frameworks",
\t\t\t\t\t"@executable_path/../../Frameworks",
\t\t\t\t);
\t\t\t\tMARKETING_VERSION = "$(FLUTTER_BUILD_NAME)";
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = com.nexushealthlabs.waterreminder.WaterWidget;
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tSKIP_INSTALL = YES;
\t\t\t\tSWIFT_EMIT_LOC_STRINGS = YES;
\t\t\t\tSWIFT_VERSION = 5.0;
\t\t\t\tTARGETED_DEVICE_FAMILY = "1,2";
\t\t\t};
\t\t\tname = Profile;
\t\t};
"""

WIDGET_CONFIG_LIST = """\
\t\tA1WGT0011CF9000F007C0014 /* Build configuration list for PBXNativeTarget "WaterWidgetExtension" */ = {
\t\t\tisa = XCConfigurationList;
\t\t\tbuildConfigurations = (
\t\t\t\tA1WGT0011CF9000F007C0015 /* Debug */,
\t\t\t\tA1WGT0011CF9000F007C0016 /* Release */,
\t\t\t\tA1WGT0011CF9000F007C0017 /* Profile */,
\t\t\t);
\t\t\tdefaultConfigurationIsVisible = 0;
\t\t\tdefaultConfigurationName = Release;
\t\t};
"""

if "WaterWidgetExtension" in PBX.read_text(encoding="utf-8"):
    print("WaterWidgetExtension already present — skip.")
    raise SystemExit(0)

INSERT_BEFORE_END_NATIVE = """\
\t\tA1WGT0011CF9000F007C0010 /* WaterWidgetExtension */ = {
\t\t\tisa = PBXNativeTarget;
\t\t\tbuildConfigurationList = A1WGT0011CF9000F007C0014 /* Build configuration list for PBXNativeTarget "WaterWidgetExtension" */;
\t\t\tbuildPhases = (
\t\t\t\tA1WGT0011CF9000F007C000D /* Sources */,
\t\t\t\tA1WGT0011CF9000F007C000E /* Frameworks */,
\t\t\t\tA1WGT0011CF9000F007C000F /* Resources */,
\t\t\t);
\t\t\tbuildRules = (
\t\t\t);
\t\t\tdependencies = (
\t\t\t);
\t\t\tname = WaterWidgetExtension;
\t\t\tproductName = WaterWidgetExtension;
\t\t\tproductReference = A1WGT0011CF9000F007C0001 /* WaterWidgetExtension.appex */;
\t\t\tproductType = "com.apple.product-type.app-extension";
\t\t};
"""

PATCHES: list[tuple[str, str]] = [
    (
        "/* End PBXBuildFile section */",
        """\
\t\tA1WGT0011CF9000F007C0018 /* WaterWidget.swift in Sources */ = {isa = PBXBuildFile; fileRef = A1WGT0011CF9000F007C0002 /* WaterWidget.swift */; };
\t\tA1WGT0011CF9000F007C0019 /* WaterWidgetViews.swift in Sources */ = {isa = PBXBuildFile; fileRef = A1WGT0011CF9000F007C0003 /* WaterWidgetViews.swift */; };
\t\tA1WGT0011CF9000F007C001A /* HydrationWidgetData.swift in Sources */ = {isa = PBXBuildFile; fileRef = A1WGT0011CF9000F007C0004 /* HydrationWidgetData.swift */; };
\t\tA1WGT0011CF9000F007C001B /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = A1WGT0011CF9000F007C0005 /* Assets.xcassets */; };
\t\tA1WGT0011CF9000F007C001C /* WidgetKit.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = A1WGT0011CF9000F007C0008 /* WidgetKit.framework */; };
\t\tA1WGT0011CF9000F007C001D /* SwiftUI.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = A1WGT0011CF9000F007C0009 /* SwiftUI.framework */; };
\t\tA1WGT0011CF9000F007C000C /* WaterWidgetExtension.appex in Embed Foundation Extensions */ = {isa = PBXBuildFile; fileRef = A1WGT0011CF9000F007C0001 /* WaterWidgetExtension.appex */; settings = {ATTRIBUTES = (RemoveHeadersOnCopy, ); }; };
/* End PBXBuildFile section */""",
    ),
    (
        "/* End PBXContainerItemProxy section */",
        """\
\t\tA1WGT0011CF9000F007C0012 /* PBXContainerItemProxy */ = {
\t\t\tisa = PBXContainerItemProxy;
\t\t\tcontainerPortal = 97C146E61CF9000F007C117D /* Project object */;
\t\t\tproxyType = 1;
\t\t\tremoteGlobalIDString = A1WGT0011CF9000F007C0010;
\t\t\tremoteInfo = WaterWidgetExtension;
\t\t};
/* End PBXContainerItemProxy section */""",
    ),
    (
        "/* End PBXCopyFilesBuildPhase section */",
        """\
\t\tA1WGT0011CF9000F007C000B /* Embed Foundation Extensions */ = {
\t\t\tisa = PBXCopyFilesBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tdstPath = "";
\t\t\tdstSubfolderSpec = 13;
\t\t\tfiles = (
\t\t\t\tA1WGT0011CF9000F007C000C /* WaterWidgetExtension.appex in Embed Foundation Extensions */,
\t\t\t);
\t\t\tname = "Embed Foundation Extensions";
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t};
/* End PBXCopyFilesBuildPhase section */""",
    ),
    (
        "/* End PBXFileReference section */",
        """\
\t\tA1WGT0011CF9000F007C0001 /* WaterWidgetExtension.appex */ = {isa = PBXFileReference; explicitFileType = "wrapper.app-extension"; includeInIndex = 0; path = WaterWidgetExtension.appex; sourceTree = BUILT_PRODUCTS_DIR; };
\t\tA1WGT0011CF9000F007C0002 /* WaterWidget.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = WaterWidget.swift; sourceTree = "<group>"; };
\t\tA1WGT0011CF9000F007C0003 /* WaterWidgetViews.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = WaterWidgetViews.swift; sourceTree = "<group>"; };
\t\tA1WGT0011CF9000F007C0004 /* HydrationWidgetData.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = HydrationWidgetData.swift; sourceTree = "<group>"; };
\t\tA1WGT0011CF9000F007C0005 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
\t\tA1WGT0011CF9000F007C0006 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
\t\tA1WGT0011CF9000F007C0007 /* WaterWidgetExtension.entitlements */ = {isa = PBXFileReference; lastKnownFileType = text.plist.entitlements; path = WaterWidgetExtension.entitlements; sourceTree = "<group>"; };
\t\tA1WGT0011CF9000F007C0008 /* WidgetKit.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = WidgetKit.framework; path = System/Library/Frameworks/WidgetKit.framework; sourceTree = SDKROOT; };
\t\tA1WGT0011CF9000F007C0009 /* SwiftUI.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = SwiftUI.framework; path = System/Library/Frameworks/SwiftUI.framework; sourceTree = SDKROOT; };
/* End PBXFileReference section */""",
    ),
    (
        "/* End PBXFrameworksBuildPhase section */",
        """\
\t\tA1WGT0011CF9000F007C000E /* Frameworks */ = {
\t\t\tisa = PBXFrameworksBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
\t\t\t\tA1WGT0011CF9000F007C001C /* WidgetKit.framework in Frameworks */,
\t\t\t\tA1WGT0011CF9000F007C001D /* SwiftUI.framework in Frameworks */,
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t};
/* End PBXFrameworksBuildPhase section */""",
    ),
    (
        "\t\t97C146E51CF9000F007C117D = {",
        """\
\t\tA1WGT0011CF9000F007C0013 /* WaterWidget */ = {
\t\t\tisa = PBXGroup;
\t\t\tchildren = (
\t\t\t\tA1WGT0011CF9000F007C0002 /* WaterWidget.swift */,
\t\t\t\tA1WGT0011CF9000F007C0003 /* WaterWidgetViews.swift */,
\t\t\t\tA1WGT0011CF9000F007C0004 /* HydrationWidgetData.swift */,
\t\t\t\tA1WGT0011CF9000F007C0005 /* Assets.xcassets */,
\t\t\t\tA1WGT0011CF9000F007C0006 /* Info.plist */,
\t\t\t);
\t\t\tpath = WaterWidget;
\t\t\tsourceTree = "<group>";
\t\t};
\t\t97C146E51CF9000F007C117D = {""",
    ),
    (
        "\t\t\tchildren = (\n\t\t\t\t9740EEB11CF90186004384FC /* Flutter */,\n\t\t\t\t97C146F01CF9000F007C117D /* Runner */,",
        "\t\t\tchildren = (\n\t\t\t\t9740EEB11CF90186004384FC /* Flutter */,\n\t\t\t\tA1WGT0011CF9000F007C0013 /* WaterWidget */,\n\t\t\t\tA1WGT0011CF9000F007C0007 /* WaterWidgetExtension.entitlements */,\n\t\t\t\t97C146F01CF9000F007C117D /* Runner */,",
    ),
    (
        "\t\t\tchildren = (\n\t\t\t\t97C146EE1CF9000F007C117D /* Runner.app */,\n\t\t\t\t331C8081294A63A400263BE5 /* RunnerTests.xctest */,",
        "\t\t\tchildren = (\n\t\t\t\t97C146EE1CF9000F007C117D /* Runner.app */,\n\t\t\t\tA1WGT0011CF9000F007C0001 /* WaterWidgetExtension.appex */,\n\t\t\t\t331C8081294A63A400263BE5 /* RunnerTests.xctest */,",
    ),
    (
        MARKER,
        INSERT_BEFORE_END_NATIVE + MARKER,
    ),
    (
        "\t\t\t\t97C146ED1CF9000F007C117D = {\n\t\t\t\t\tCreatedOnToolsVersion = 7.3.1;\n\t\t\t\t\tLastSwiftMigration = 1100;\n\t\t\t\t};",
        "\t\t\t\t97C146ED1CF9000F007C117D = {\n\t\t\t\t\tCreatedOnToolsVersion = 7.3.1;\n\t\t\t\t\tLastSwiftMigration = 1100;\n\t\t\t\t};\n\t\t\t\tA1WGT0011CF9000F007C0010 = {\n\t\t\t\t\tCreatedOnToolsVersion = 15.0;\n\t\t\t\t};",
    ),
    (
        "\t\t\ttargets = (\n\t\t\t\t97C146ED1CF9000F007C117D /* Runner */,\n\t\t\t\t331C8080294A63A400263BE5 /* RunnerTests */,",
        "\t\t\ttargets = (\n\t\t\t\t97C146ED1CF9000F007C117D /* Runner */,\n\t\t\t\t331C8080294A63A400263BE5 /* RunnerTests */,\n\t\t\t\tA1WGT0011CF9000F007C0010 /* WaterWidgetExtension */,",
    ),
    (
        "/* End PBXResourcesBuildPhase section */",
        """\
\t\tA1WGT0011CF9000F007C000F /* Resources */ = {
\t\t\tisa = PBXResourcesBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
\t\t\t\tA1WGT0011CF9000F007C001B /* Assets.xcassets in Resources */,
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t};
/* End PBXResourcesBuildPhase section */""",
    ),
    (
        "\t\t\tbuildPhases = (\n\t\t\t\t9740EEB61CF901F6004384FC /* Run Script */,\n\t\t\t\t97C146EA1CF9000F007C117D /* Sources */,\n\t\t\t\t97C146EB1CF9000F007C117D /* Frameworks */,\n\t\t\t\t97C146EC1CF9000F007C117D /* Resources */,\n\t\t\t\t9705A1C41CF9048500538489 /* Embed Frameworks */,\n\t\t\t\t3B06AD1E1E4923F5004D2608 /* Thin Binary */,",
        "\t\t\tbuildPhases = (\n\t\t\t\t9740EEB61CF901F6004384FC /* Run Script */,\n\t\t\t\t97C146EA1CF9000F007C117D /* Sources */,\n\t\t\t\t97C146EB1CF9000F007C117D /* Frameworks */,\n\t\t\t\t97C146EC1CF9000F007C117D /* Resources */,\n\t\t\t\t9705A1C41CF9048500538489 /* Embed Frameworks */,\n\t\t\t\tA1WGT0011CF9000F007C000B /* Embed Foundation Extensions */,\n\t\t\t\t3B06AD1E1E4923F5004D2608 /* Thin Binary */,",
    ),
    (
        "\t\t\tdependencies = (\n\t\t\t);\n\t\t\tname = Runner;",
        "\t\t\tdependencies = (\n\t\t\t\tA1WGT0011CF9000F007C0011 /* PBXTargetDependency */,\n\t\t\t);\n\t\t\tname = Runner;",
    ),
    (
        "/* End PBXSourcesBuildPhase section */",
        """\
\t\tA1WGT0011CF9000F007C000D /* Sources */ = {
\t\t\tisa = PBXSourcesBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
\t\t\t\tA1WGT0011CF9000F007C0018 /* WaterWidget.swift in Sources */,
\t\t\t\tA1WGT0011CF9000F007C0019 /* WaterWidgetViews.swift in Sources */,
\t\t\t\tA1WGT0011CF9000F007C001A /* HydrationWidgetData.swift in Sources */,
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t};
/* End PBXSourcesBuildPhase section */""",
    ),
    (
        "/* End PBXTargetDependency section */",
        """\
\t\tA1WGT0011CF9000F007C0011 /* PBXTargetDependency */ = {
\t\t\tisa = PBXTargetDependency;
\t\t\ttarget = A1WGT0011CF9000F007C0010 /* WaterWidgetExtension */;
\t\t\ttargetProxy = A1WGT0011CF9000F007C0012 /* PBXContainerItemProxy */;
\t\t};
/* End PBXTargetDependency section */""",
    ),
    (
        "/* End XCBuildConfiguration section */",
        WIDGET_BUILD_CONFIGS + "/* End XCBuildConfiguration section */",
    ),
    (
        "/* End XCConfigurationList section */",
        WIDGET_CONFIG_LIST + "/* End XCConfigurationList section */",
    ),
]

def main() -> None:
    text = PBX.read_text(encoding="utf-8")
    for old, new in PATCHES:
        if old not in text:
            raise SystemExit(f"Patch anchor not found: {old[:60]!r}...")
        text = text.replace(old, new, 1)
    PBX.write_text(text, encoding="utf-8")
    print("Patched", PBX)


if __name__ == "__main__":
    main()
