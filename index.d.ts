export declare class HOInterval {
    public a: number;
    public b: number;
    static clone(int: HOInterval): HOInterval;
    static length(int: HOInterval): number;
    static isValid(int: HOInterval): boolean;
    static isValid(a: number, b: number): boolean;
    static unite(ints: HOInterval[]): HOInterval[];
    static gaps(ints: HOInterval[]): HOInterval[];
    static intersect(a: HOInterval, b: HOInterval): HOInterval;
    constructor(a: number, b: number);
    public isCloseTo(other: HOInterval): boolean;
    public isEqualsTo(other: HOInterval): boolean;
    public isIntersect(other: HOInterval): boolean;
    public isIntersect(x: number, y: number): boolean;
    public unite(other: HOInterval): HOInterval;
    public intersect(other: any): HOInterval;
    public add(val: number): HOInterval;
}
