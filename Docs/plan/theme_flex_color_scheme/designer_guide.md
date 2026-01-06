# Designer Guide: Theme Definition in Figma

## Overview

This guide explains how to define and organize themes in Figma for seamless integration with our FlexColorScheme-based theme system. Our app uses a sophisticated color palette system with custom shades, component variants, and Material Design 3 principles.

## 🎨 Color System Architecture

### Primary Color Palette (Red Theme)

Our primary colors use a 13-shade system from 0-99:

| Shade | Usage | Figma Color | Hex Code |
|-------|-------|-------------|----------|
| 99 | Very light backgrounds | Light Red 99 | `#FCEFF0` |
| 95 | Light backgrounds | Light Red 95 | `#F8DADD` |
| 90 | Subtle backgrounds | Light Red 90 | `#F1B2B8` |
| 80 | Light borders | Light Red 80 | `#E15A66` |
| 70 | Hover states | Light Red 70 | `#DB3645` |
| 60 | **Main Primary** | Light Red 60 | `#D51224` |
| 50 | Active states | Light Red 50 | `#B40F1E` |
| 40 | Dark borders | Light Red 40 | `#930C18` |
| 30 | Dark backgrounds | Light Red 30 | `#720913` |
| 20 | Very dark backgrounds | Light Red 20 | `#51060D` |
| 10 | Text on dark | Light Red 10 | `#300408` |
| 0 | Pure black | Black | `#000000` |

### Secondary Color Palette (Blue Theme)

Same 13-shade system for consistency:

| Shade | Usage | Figma Color | Hex Code |
|-------|-------|-------------|----------|
| 99 | Very light backgrounds | Light Blue 99 | `#EAF7FC` |
| 95 | Light backgrounds | Light Blue 95 | `#D5EFFA` |
| 90 | Subtle backgrounds | Light Blue 90 | `#ABDFF5` |
| 80 | Light borders | Light Blue 80 | `#82CEEF` |
| 70 | Hover states | Light Blue 70 | `#43B6E8` |
| 60 | **Main Secondary** | Light Blue 60 | `#009CDF` |
| 50 | Active states | Light Blue 50 | `#258BB7` |
| 40 | Dark borders | Light Blue 40 | `#1C6889` |
| 30 | Dark backgrounds | Light Blue 30 | `#12465C` |
| 20 | Very dark backgrounds | Light Blue 20 | `#09232E` |
| 10 | Text on dark | Light Blue 10 | `#051117` |
| 0 | Pure black | Black | `#000000` |

### Text Color Palette (Gray Scale)

Text colors for optimal readability:

| Shade | Usage | Figma Color | Hex Code |
|-------|-------|-------------|----------|
| 100 | Pure white backgrounds | White | `#FFFFFF` |
| 99 | Very light backgrounds | Gray 99 | `#F4F4F4` |
| 95 | Light backgrounds | Gray 95 | `#EAEAEA` |
| 90 | Subtle backgrounds | Gray 90 | `#D4D4D5` |
| 80 | Light borders | Gray 80 | `#BFBEC0` |
| 70 | Disabled text | Gray 70 | `#A9A8AA` |
| 60 | **Body text** | Gray 60 | `#929295` |
| 50 | Secondary text | Gray 50 | `#7D7D80` |
| 40 | Dark borders | Gray 40 | `#68686B` |
| 30 | Dark backgrounds | Gray 30 | `#525256` |
| 20 | Very dark backgrounds | Gray 20 | `#3D3C41` |
| 10 | Text on dark | Gray 10 | `#27262C` |
| 0 | Pure black | Black | `#000000` |

### Semantic Colors

| Color | Usage | Light Hex | Dark Hex |
|-------|-------|-----------|----------|
| Sunrise Yellow | Success, warnings | `#FFC53D` | `#FAAD14` |
| Green | Success states | `#73D13D` | `#52C41A` |
| Base | Neutral backgrounds | `#525256` | `#D51224` |

## 🖼️ Figma Organization Structure

### 1. Create Color Styles

```
📁 Color Styles/
├── 📁 Primary/
│   ├── Primary/99
│   ├── Primary/95
│   ├── Primary/90
│   ├── Primary/80
│   ├── Primary/70
│   ├── Primary/60 (Main)
│   ├── Primary/50
│   ├── Primary/40
│   ├── Primary/30
│   ├── Primary/20
│   ├── Primary/10
│   └── Primary/0
├── 📁 Secondary/
│   └── [Same structure as Primary]
├── 📁 Text/
│   └── [Same structure as Primary]
├── 📁 Semantic/
│   ├── Sunrise Yellow/60
│   ├── Green/60
│   └── Base/30
└── 📁 Component States/
    ├── Hover
    ├── Pressed
    ├── Disabled
    └── Selected
```

### 2. Create Text Styles

```
📁 Text Styles/
├── 📁 Display/
│   ├── Display Large (60pt, Bold)
│   ├── Display Medium (52pt, Medium)
│   └── Display Small (40pt, Regular)
├── 📁 Headline/
│   ├── Headline Large (34pt, Regular)
│   ├── Headline Medium (28pt, Regular)
│   └── Headline Small (24pt, Regular)
├── 📁 Title/
│   ├── Title Large (20pt, Regular)
│   ├── Title Medium (16pt, Medium)
│   └── Title Small (14pt, Medium)
├── 📁 Body/
│   ├── Body Large (16pt, Regular)
│   ├── Body Medium (14pt, Regular)
│   └── Body Small (12pt, Regular)
└── 📁 Label/
    ├── Label Large (14pt, Bold)
    ├── Label Medium (12pt, Bold)
    └── Label Small (10pt, Bold)
```

**Font Family:** IRANSansX (for Persian text) / System Font (for English)

## 🔘 Component Definition Guidelines

### Button Variants

#### 1. Elevated Button (Primary)

```
🎨 Background: Primary/60 (#D51224)
🎨 Text/Icon: Text/100 (#FFFFFF)
🎨 Border: None
🎨 Shadow: Elevation 2
🎨 Border Radius: 16px
🎨 Padding: 12px horizontal, 6px vertical
```

#### 2. Outlined Button (Secondary)

```
🎨 Background: Primary/100 (#FFFFFF)
🎨 Text/Icon: Text/10 (#27262C)
🎨 Border: 1.5px, Text/90 (#D4D4D5)
🎨 Shadow: None
🎨 Border Radius: 16px
🎨 Padding: 12px horizontal, 6px vertical
```

#### 3. Text Button (Tertiary)

```
🎨 Background: Primary/100 (#FFFFFF)
🎨 Text/Icon: Text/10 (#27262C)
🎨 Border: None
🎨 Shadow: None
🎨 Border Radius: 16px
🎨 Padding: 12px horizontal, 6px vertical
```

#### 4. Success Button

```
🎨 Background: Green/60 (#73D13D)
🎨 Text/Icon: Text/100 (#FFFFFF)
🎨 Border: None
🎨 Shadow: Elevation 2
🎨 Border Radius: 16px
🎨 Padding: 12px horizontal, 6px vertical
```

#### 5. Error Button

```
🎨 Background: Primary/60 (#D51224)
🎨 Text/Icon: Text/100 (#FFFFFF)
🎨 Border: None
🎨 Shadow: Elevation 2
🎨 Border Radius: 16px
🎨 Padding: 12px horizontal, 6px vertical
```

#### 6. Warning Button

```
🎨 Background: Sunrise Yellow/60 (#FFC53D)
🎨 Text/Icon: Text/0 (#000000)
🎨 Border: None
🎨 Shadow: Elevation 2
🎨 Border Radius: 16px
🎨 Padding: 12px horizontal, 6px vertical
```

### Interactive States

#### Hover State

```
🎨 Background: Primary/70 (#DB3645) for primary buttons
🎨 Background: Primary/99 (#FCEFF0) for outlined buttons
🎨 Text/Icon: Unchanged
```

#### Pressed State

```
🎨 Background: Primary/50 (#B40F1E) for primary buttons
🎨 Border: Primary/50 (#B40F1E) for outlined buttons
🎨 Text/Icon: Unchanged
```

#### Disabled State

```
🎨 Background: Text/99 (#F4F4F4)
🎨 Text/Icon: Text/70 (#A9A8AA)
🎨 Border: Text/90 (#D4D4D5)
```

## 🔄 Form Components

### Switches

```
🎨 Track (Off): Text/90 (#D4D4D5)
🎨 Track (On): Primary/60 (#D51224) with 30% opacity
🎨 Thumb: Primary/100 (#FFFFFF)
🎨 Border: Primary/60 (#D51224) when on
🎨 Size: 24px thumb, 4px border radius
```

### Checkboxes

```
🎨 Fill (Unchecked): Transparent
🎨 Fill (Checked): Primary/60 (#D51224)
🎨 Check Mark: Primary/100 (#FFFFFF)
🎨 Border: 1.5px, Text/60 (#929295)
🎨 Border Radius: 4px
🎨 Size: 18px
```

### Radio Buttons

```
🎨 Fill (Unchecked): Transparent
🎨 Fill (Checked): Primary/60 (#D51224)
🎨 Border: 2px, Text/60 (#929295)
🎨 Size: 20px outer, 8px inner
```

## 📱 Layout Components

### App Bar

```
🎨 Background: Text/100 (#FFFFFF) - Light mode
🎨 Background: Text/10 (#27262C) - Dark mode
🎨 Title Text: Primary/60 (#D51224)
🎨 Icons: Text/10 (#27262C) - Light mode
🎨 Icons: Text/100 (#FFFFFF) - Dark mode
🎨 Elevation: 0 (flat design)
```

### Bottom Navigation

```
🎨 Background: Text/100 (#FFFFFF) - Light mode
🎨 Background: Text/10 (#27262C) - Dark mode
🎨 Selected Item: Primary/50 (#B40F1E)
🎨 Unselected Item: Text/60 (#929295)
🎨 Border Radius: 0 (full width)
```

### Cards

```
🎨 Background: Primary/100 (#FFFFFF) - Light mode
🎨 Background: Text/20 (#3D3C41) - Dark mode
🎨 Border: None
🎨 Shadow: Elevation 2
🎨 Border Radius: 12px
```

## 🎭 Gradients & Advanced Styles

### Primary Gradient

```
🎨 Start: Primary/60 (#D51224)
🎨 End: Primary/40 (#930C18)
🎨 Direction: 180° (top to bottom)
```

### Success Gradient

```
🎨 Start: Green/60 (#73D13D)
🎨 End: Green/40 (#389E0D)
🎨 Direction: 180° (top to bottom)
```

### Sunrise Gradient

```
🎨 Start: Sunrise Yellow/60 (#FFC53D)
🎨 End: Sunrise Yellow/40 (#D48806)
🎨 Direction: 180° (top to bottom)
```

## 📐 Spacing & Sizing System

### Border Radius

- Buttons: 16px
- Cards: 12px
- Inputs: 8px
- Chips: 8px
- Dialogs: 12px

### Elevation

- Cards: 2
- App Bars: 0 (flat)
- Buttons: 2 (elevated), 0 (outlined/text)
- Bottom Nav: 4

### Spacing Scale

- 4px (xs)
- 6px (sm)
- 8px (md)
- 12px (lg)
- 16px (xl)
- 20px (xxl)

## 🌙 Dark Mode Guidelines

### Automatic Color Mapping

Our system automatically generates dark mode colors by inverting the shade system:

**Light Mode Primary/60 → Dark Mode Primary/40**
**Light Mode Text/10 → Dark Mode Text/90**

### Manual Adjustments Needed

- App backgrounds: Use Text/10 instead of Text/100
- Text colors: Use Text/100 on dark backgrounds
- Borders: Use Text/30 instead of Text/90
- Subtle backgrounds: Use Text/20 instead of Text/99

## 🔧 Custom Components

### When Creating New Components

1. **Use Existing Colors**: Always reference the color palette, don't create new colors
2. **Follow Shade System**: Use appropriate shades (60 for main, 50 for active, 70 for hover, etc.)
3. **Match Border Radius**: Use established values (16px for buttons, 12px for cards, etc.)
4. **Include All States**: Hover, pressed, disabled, selected, focus
5. **Test Contrast**: Ensure WCAG AA compliance (4.5:1 ratio)
6. **Document Usage**: Add to this guide when creating new patterns

### Custom Input Fields

```
🎨 Background: Primary/100 (#FFFFFF)
🎨 Border: 1.5px, Text/90 (#D4D4D5) - normal
🎨 Border: 1.5px, Primary/60 (#D51224) - focused
🎨 Border Radius: 8px
🎨 Padding: 12px horizontal, 8px vertical
🎨 Label: Text/40 (#68686B) - normal
🎨 Label: Primary/60 (#D51224) - focused
```

## 📋 Designer-Developer Workflow

### 1. Component Creation Process

```
1. Designer creates component in Figma
2. Designer documents colors, spacing, states
3. Designer exports assets (if needed)
4. Developer implements using FlexColorScheme
5. Developer tests all states and variants
6. Team reviews and approves
7. Documentation updated
```

### 2. Color Addition Process

```
1. Designer proposes new color with use case
2. Team reviews against existing palette
3. If approved, add to shade system (0-99)
4. Update Figma library
5. Update code constants
6. Test across all components
7. Update documentation
```

### 3. Component Modification Process

```
1. Identify component and desired changes
2. Check impact on existing screens
3. Update Figma master component
4. Update code implementation
5. Test all states and breakpoints
6. Update documentation
7. Communicate changes to team
```

## 📊 Color Token Naming Convention

### Figma Style Names

```
Color/Primary/60
Color/Secondary/50
Color/Text/10
Color/Semantic/Success/60
Color/Component/Button/Hover
```

### Code References

```dart
// Primary colors
Theme.of(context).extension<AppColorPalette>()!.primary.shade60

// Component states
Theme.of(context).extension<AppButtonTheme>()!.primary

// Gradients
Theme.of(context).extension<AppDecorations>()!.gradients.primary
```

## ✅ Checklist for New Designs

- [ ] Uses only defined color palette
- [ ] Follows shade system (0-99)
- [ ] Includes all interactive states
- [ ] Meets contrast requirements
- [ ] Uses established spacing scale
- [ ] Follows border radius guidelines
- [ ] Works in both light and dark modes
- [ ] Tested on multiple screen sizes
- [ ] Documented in this guide

## 🚨 Important Notes

1. **Never create new colors** without adding them to the shade system
2. **Always test dark mode** - our system auto-generates, but verify it looks good
3. **Use semantic names** - prefer "Primary" over "Red", "Success" over "Green"
4. **Document everything** - Update this guide when creating new patterns
5. **Test Persian text** - Ensure IRANSansX font works with your designs
6. **Consider accessibility** - All text should meet WCAG AA standards

## 📞 Questions?

When in doubt:

1. Check existing components for patterns
2. Look at the color palette documentation
3. Ask the development team about implementation constraints
4. Test your design in both light and dark modes
5. Ensure Persian text displays correctly

---

**Last Updated:** January 6, 2026
**Version:** 1.0
**Contact:** Development Team
