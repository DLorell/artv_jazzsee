import processing.sound.*;
import java.util.concurrent.ThreadLocalRandom;

String MIDDLESOUNDDIR = "middle_tracks/";
String OUTROSOUNDDIR = "outro_tracks/";

public class SongStitcher {
  MySoundFile[] middle_sounds;
  MySoundFile[] outro_sounds;
  Integer[] song;
  int numTracks;
  int curTrack = -1;

  public SongStitcher(int duration){
    middle_sounds = _loadClips(MIDDLESOUNDDIR);
    outro_sounds = _loadClips(OUTROSOUNDDIR);
    song = _generateIdxs(duration);
    numTracks = song.length;
  }
  
  public String step(){
    if(curTrack == numTracks-1 && !outro_sounds[song[curTrack]].sound.isPlaying()){
      // The outro has ended. The song is over.
      return "END OF SONG";
    }
    
    if(curTrack == numTracks-2 && !middle_sounds[song[curTrack]].sound.isPlaying()){
      // Time to play the outro!
      curTrack++;
      outro_sounds[song[curTrack]].sound.play();
    }else if(curTrack < 0 || (curTrack < numTracks-2 && !middle_sounds[song[curTrack]].sound.isPlaying())){
      // Start of song, or old track has finished and not time for outro
      // Proceed to the next track.
      curTrack++;
      middle_sounds[song[curTrack]].sound.play();
    }
    
    if(curTrack == numTracks-1){
      // Outro is playing
      return outro_sounds[song[curTrack]].fileName;
    }else{
      // Middle sound is playing
      return middle_sounds[song[curTrack]].fileName;
    }
  }
  
  private MySoundFile[] _loadClips(String filedir){
    String[] files = _listFileNames(sketchPath() + "/data/" + filedir);
    MySoundFile[] loaded = new MySoundFile[files.length];
    for(int i = 0; i < files.length; i++){
      loaded[i] = new MySoundFile(new SoundFile(groupProj.this, filedir + files[i]), filedir + files[i]);
    }
    return loaded;
  }
  
  private Integer[] _generateIdxs(int duration){
    float totalDuration = 0;
    ArrayList<Integer> idxs = new ArrayList<Integer>();

    int outroIdx = ThreadLocalRandom.current().nextInt(0, outro_sounds.length);
    totalDuration += outro_sounds[outroIdx].sound.duration();
    // Then add the outro Idx after all the middle idxs.
    
    while(totalDuration < duration){
      int soundIdx = ThreadLocalRandom.current().nextInt(0, middle_sounds.length);
      idxs.add(soundIdx);
      totalDuration += middle_sounds[soundIdx].sound.duration();
    }
    
    idxs.add(outroIdx);
    
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
  OtherData imageMaybe;
  String fileName;
  
  public MySoundFile(SoundFile sFile, String _fileName){
    sound = sFile;
    fileName = _fileName;
    imageMaybe = new OtherData();
  }
};


// This is a useless class meant to illustrate the purpose of the MySoundFile class.
public class OtherData{
  public OtherData(){
  }
}
