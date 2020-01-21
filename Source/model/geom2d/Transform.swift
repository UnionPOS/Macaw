import Foundation

public final class Transform {

    public let m11: Double
    public let m12: Double
    public let m21: Double
    public let m22: Double
    public let dx: Double
    public let dy: Double

    public static let identity: Transform = Transform()

    public init(m11: Double = 1, m12: Double = 0, m21: Double = 0, m22: Double = 1, dx: Double = 0, dy: Double = 0) {
        print("Transform:init")
        self.m11 = m11
        self.m12 = m12
        self.m21 = m21
        self.m22 = m22
        self.dx = dx
        self.dy = dy
    }

    deinit {
        print("Transform:deinit")
    }

    public func move(dx: Double, dy: Double) -> Transform {
        return Transform(m11: m11, m12: m12, m21: m21, m22: m22,
                         dx: dx * m11 + dy * m21 + self.dx, dy: dx * m12 + dy * m22 + self.dy)
    }

    public func scale(sx: Double, sy: Double) -> Transform {
        return Transform(m11: m11 * sx, m12: m12 * sx, m21: m21 * sy, m22: m22 * sy, dx: dx, dy: dy)
    }

    public func shear(shx: Double, shy: Double) -> Transform {
        return Transform(m11: m11 + m21 * shy, m12: m12 + m22 * shy,
                         m21: m11 * shx + m21, m22: m12 * shx + m22, dx: dx, dy: dy)
    }

    public func rotate(angle: Double) -> Transform {
        let asin = sin(angle); let acos = cos(angle)
        return Transform(m11: acos * m11 + asin * m21, m12: acos * m12 + asin * m22,
                         m21: -asin * m11 + acos * m21, m22: -asin * m12 + acos * m22, dx: dx, dy: dy)
    }

    public func rotate(angle: Double, x: Double, y: Double) -> Transform {
        return move(dx: x, dy: y).rotate(angle: angle).move(dx: -x, dy: -y)
    }

    public class func move(dx: Double, dy: Double) -> Transform {
        return Transform(dx: dx, dy: dy)
    }

    public class func scale(sx: Double, sy: Double) -> Transform {
        return Transform(m11: sx, m22: sy)
    }

    public class func shear(shx: Double, shy: Double) -> Transform {
        return Transform(m12: shy, m21: shx)
    }

    public class func rotate(angle: Double) -> Transform {
        let asin = sin(angle); let acos = cos(angle)
        return Transform(m11: acos, m12: asin, m21: -asin, m22: acos)
    }

    public class func rotate(angle: Double, x: Double, y: Double) -> Transform {
        return Transform.move(dx: x, dy: y).rotate(angle: angle).move(dx: -x, dy: -y)
    }

    public func concat(with: Transform) -> Transform {
        let nm11 = with.m11 * m11 + with.m12 * m21
        let nm21 = with.m21 * m11 + with.m22 * m21
        let ndx = with.dx * m11 + with.dy * m21 + dx
        let nm12 = with.m11 * m12 + with.m12 * m22
        let nm22 = with.m21 * m12 + with.m22 * m22
        let ndy = with.dx * m12 + with.dy * m22 + dy
        return Transform(m11: nm11, m12: nm12, m21: nm21, m22: nm22, dx: ndx, dy: ndy)
    }

    public func invert() -> Transform? {
        let det = self.m11 * self.m22 - self.m12 * self.m21
        if det == 0 {
            return nil
        }
        return Transform(m11: m22 / det, m12: -m12 / det, m21: -m21 / det, m22: m11 / det,
                         dx: (m21 * dy - m22 * dx) / det,
                         dy: (m12 * dx - m11 * dy) / det)
    }
}
