import UIKit

public final class ConstraintMaker {
    private let view: UIView
    private var constraints: [NSLayoutConstraint] = []
    
    // MARK: - Initializer
    public init(view: UIView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Methods for Constraints
    public func top(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) {
        constraints.append(createConstraint(view.topAnchor, to: anchor, constant: constant, relation: relation))
    }
    
    public func bottom(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) {
        constraints.append(createConstraint(view.bottomAnchor, to: anchor, constant: -constant, relation: relation))
    }
    
    public func leading(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) {
        constraints.append(createConstraint(view.leadingAnchor, to: anchor, constant: constant, relation: relation))
    }
    
    public func trailing(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) {
        constraints.append(createConstraint(view.trailingAnchor, to: anchor, constant: -constant, relation: relation))
    }
    
    public func centerX(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        constraints.append(view.centerXAnchor.constraint(equalTo: anchor, constant: constant))
    }
    
    public func centerY(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        constraints.append(view.centerYAnchor.constraint(equalTo: anchor, constant: constant))
    }
    
    public func width(equalTo constant: CGFloat) {
        constraints.append(view.widthAnchor.constraint(equalToConstant: constant))
    }
    
    public func height(equalTo constant: CGFloat) {
        constraints.append(view.heightAnchor.constraint(equalToConstant: constant))
    }
    
    // MARK: - Activate Constraints
    public func activateConstraints() {
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Private Helper
extension ConstraintMaker {
    private func createConstraint<AnchorType>(
        _ anchor: NSLayoutAnchor<AnchorType>,
        to otherAnchor: NSLayoutAnchor<AnchorType>,
        constant: CGFloat,
        relation: NSLayoutConstraint.Relation
    ) -> NSLayoutConstraint {
        switch relation {
            case .equal:
                return anchor.constraint(equalTo: otherAnchor, constant: constant)
            case .greaterThanOrEqual:
                return anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
            case .lessThanOrEqual:
                return anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant)
            @unknown default:
                fatalError("Unsupported NSLayoutConstraint.Relation: \(relation)")
        }
    }
}
