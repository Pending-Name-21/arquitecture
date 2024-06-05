package implementation.renderHandlerImplementation.sprite;

import implementation.renderHandlerImplementation.factory.ISpriteFactory;


public class SpriteFactory implements ISpriteFactory {
    @Override
    public Sprite createSprite() {

        return new Sprite();
    }
}
