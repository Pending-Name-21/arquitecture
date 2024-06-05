package implementation.renderHandlerImplementation;

import implementation.renderHandlerImplementation.sprite.*;
import implementation.renderHandlerImplementation.sound.*;

public class RenderManager {
    private SpriteRenderer spriteRenderer;
    private SoundPlayer soundPlayer;

    public RenderManager(SpriteRenderer spriteRenderer, SoundPlayer soundPlayer) {
        this.spriteRenderer = spriteRenderer;
        this.soundPlayer = soundPlayer;
    }

    public void renderSprites() {
        for (Sprite sprite : spriteRenderer.getSprites()) {
            spriteRenderer.renderSprite(sprite);
        }
    }

    public void playSounds() {
        for (Sound sound : soundPlayer.getSounds()) {
            soundPlayer.playSound(sound);
        }
    }
}