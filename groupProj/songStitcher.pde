import processing.sound.*;
import java.util.Random;
import java.util.Arrays;

String MIDDLESOUNDDIR = "middle_tracks/";
String OUTROSOUNDDIR = "outro_tracks/";
String MIDDLEIMGDIR = "middle_primitives/";
String OUTROIMGDIR = "outro_primitives/";

public class SongStitcher {
  
  int RANDOMSEED;
  
  MySoundFile[] middle_sounds;
  MySoundFile[] outro_sounds;
  PImage[] middle_primitives;
  PImage[] outro_primitives;
  Integer[] song;
  int numTracks;
  int curTrack = -1;

  public SongStitcher(int duration, int row_h, int col_w, int seed){
    RANDOMSEED = seed;
    middle_primitives = _loadImgs(MIDDLEIMGDIR, row_h, col_w);
    outro_primitives = _loadImgs(OUTROIMGDIR, row_h, col_w);
    middle_sounds = _loadClips(MIDDLESOUNDDIR, middle_primitives);
    outro_sounds = _loadClips(OUTROSOUNDDIR, outro_primitives);
    song = _generateIdxs(duration);
    numTracks = song.length;
  }
  
  public MySoundFile step(){
    if(curTrack == numTracks-1 && !outro_sounds[song[curTrack]].sound.isPlaying()){
      // The outro has ended. The song is over.
      return null;
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
      return outro_sounds[song[curTrack]];
    }else{
      // Middle sound is playing
      return middle_sounds[song[curTrack]];
    }
  }
  
  private PImage[] _loadImgs(String filedir, int h, int w){
    String[] files = _listFileNames(sketchPath() + "/data/" + filedir);
    PImage[] loaded = new PImage[files.length];
    for(int i = 0; i < files.length; i++){
      loaded[i] = loadImage(filedir + files[i]);
      loaded[i].resize(h, w);
    }
    return loaded;
  }
  
  private MySoundFile[] _loadClips(String filedir, PImage[] imgs){
    String[] files = _listFileNames(sketchPath() + "/data/" + filedir);
    MySoundFile[] loaded = new MySoundFile[files.length];
    for(int i = 0; i < files.length; i++){
      SoundFile sound = new SoundFile(groupProj.this, filedir + files[i]);
      String sound_file_path = filedir + files[i];
      loaded[i] = new MySoundFile(sound, sound_file_path, imgs[i%imgs.length]);
    }
    return loaded;
  }
  
  private Integer[] _generateIdxs(int duration){
    float totalDuration = 0;
    ArrayList<Integer> idxs = new ArrayList<Integer>();
    Random generator = new Random(RANDOMSEED);

    int outroIdx = generator.nextInt(outro_sounds.length);
    totalDuration += outro_sounds[outroIdx].sound.duration();
    // Then add the outro Idx after all the middle idxs.
    
    while(totalDuration < duration){
      int soundIdx = generator.nextInt(middle_sounds.length);
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
      shuffleArray(names);
      return names;
    } else {
      // If it's not a directory
      return null;
    }
  }
  
  private void shuffleArray(String[] array)
  {
    int index;
    Random random = new Random(RANDOMSEED);
    for (int i = array.length - 1; i > 0; i--)
    {
      index = random.nextInt(i + 1);
      if (index != i)
      {
        String tmp = array[index];
        array[index] = array[i];
        array[i] = tmp;
      }
    }
  }
};



public class MySoundFile{
  SoundFile sound;
  PImage img;
  String fileName;
  
  public MySoundFile(SoundFile sFile, String _fileName, PImage _img){
    sound = sFile;
    fileName = _fileName;
    img = _img;
  }
};
