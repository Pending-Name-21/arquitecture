package implementation.renderHandlerImplementation.sound;

import implementation.renderHandlerImplementation.factory.ISoundFactory;


public class SoundFactory implements ISoundFactory {
    @Override
    public Sound createSound() {
        return new Sound();
    }
}