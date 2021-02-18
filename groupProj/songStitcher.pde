import processing.sound.*;
import java.util.concurrent.ThreadLocalRandom;

String SOUNDDIR = "/data";
String IMGDIR = "/primitives";

public class SongStitcher {
  MySoundFile[] sounds;
  Integer[] song;
  int numTracks;
  int curTrack = -1;

  public SongStitcher(int duration){
    sounds = _loadClips();
    song = _generateIdxs(duration);
    numTracks = song.length;
  }
  
  public String step(){
    if(curTrack < 0 || (curTrack < numTracks && !sounds[song[curTrack]].sound.isPlaying())){
      // Attempt to proceed to the next track.
      curTrack++;
      
      if(curTrack >= numTracks){
        // Song is over
        return "END OF SONG";
      }
      else{
        sounds[song[curTrack]].sound.play();
      }
    }
    
    if(curTrack >= numTracks){
      // Song is over
      return "END OF SONG";
    }
    else{
      return sounds[song[curTrack]].fileName, sounds[song[curTrack]].imgName;
    }
  }
  
  private MySoundFile[] _loadClips(){
    String[] files = _listFileNames(sketchPath() + SOUNDDIR);
    String[] imgs = _listFileNames(sketchPath() + IMGDIR);
    MySoundFile[] loaded = new MySoundFile[files.length];
    for(int i = 0; i < files.length; i++){
      loaded[i] = new MySoundFile(new SoundFile(groupProj.this, files[i]), imgs[i]);
    }
    return loaded;
  }
  
  private Integer[] _generateIdxs(int duration){
    float totalDuration = 0;
    ArrayList<Integer> idxs = new ArrayList<Integer>();
    while(totalDuration < duration){
      int soundIdx = ThreadLocalRandom.current().nextInt(0, sounds.length);
      idxs.add(soundIdx);
      totalDuration += sounds[soundIdx].sound.duration();
    }
    Integer[] out = new Integer[idxs.size()];
    return idxs.toArray(out);
  }
  
  private String[] _listFileNames(String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
      String names[] = file.list();
      return names;
    } else {
      // If it's not a directory
      return null;
    }
  }
};



public class MySoundFile{
  SoundFile sound;
  String imageMaybe;
  String fileName;
  
  public MySoundFile(SoundFile sFile, String _fileName){
    sound = sFile;
    fileName = _fileName;
    imageMaybe = _fileName;
  }
};


// This is a useless class meant to illustrate the purpose of the MySoundFile class.
public class OtherData{
  public OtherData(){
  }
}
