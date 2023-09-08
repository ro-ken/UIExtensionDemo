const TAG: string = '=== Stage AMS ==='

export default class Logger {
    public static log(tag, ...args: any[]) {
        console.log(`${TAG}.${tag}: ${args.join('')}`)
    }

    public static info(tag, ...args: any[]) {
        console.info(`${TAG}.${tag}: ${args.join('')}`)
    }

    public static debug(tag, ...args: any[]) {
        console.debug(`${TAG}.${tag}: ${args.join('')}`)
    }

    public static warn(tag, ...args: any[]) {
        console.warn(`${TAG}.${tag}: ${args.join('')}`)
    }

    public static error(tag, ...args: any[]) {
        console.error(`${TAG}.${tag}: ${args.join('')}`)
    }
}