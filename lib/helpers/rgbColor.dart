class RGBColor
{
    final int r;
    final int g;
    final int b;

    const RGBColor({
        this.r,
        this.g,
        this.b
    });

    Map<dynamic, dynamic> toJson() => {
        'r': r,
        'g': g,
        'b': b
    };
}
